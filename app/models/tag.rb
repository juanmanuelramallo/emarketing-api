class Tag < ApplicationRecord
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :contacts
  belongs_to :user

  validates :name, uniqueness: { scope: :user_id }

  def self.count_with_contacts(current_user)
    contacts_grouped_by_tag = current_user.contacts.joins(:tags).group("tags.name").count
    contacts_grouped_by_tag_sorted = contacts_grouped_by_tag.sort_by { |tag_name, count| count }.reverse
    contacts_grouped_by_tag = contacts_grouped_by_tag_sorted.take(9).to_a
    others_count = (contacts_grouped_by_tag_sorted.to_a - contacts_grouped_by_tag).to_h.inject(0) do |sum, (tag_name, count)|
      sum += count
    end
    contacts_grouped_by_tag.push(["Otros", others_count ]).to_h
  end
end
