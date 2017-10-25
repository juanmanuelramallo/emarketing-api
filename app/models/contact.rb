class Contact < ApplicationRecord
  include PgSearch
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :tags

  pg_search_scope :search_by_full_name_or_email,
                  against: [
                    [:first_name, 'A'],
                    [:last_name, 'B'],
                    [:email, 'C']
                  ],
                  using: {
                    tsearch: { prefix: true }
                  },
                  ignoring: :accents

  validates :first_name, :last_name, :email, presence: true
end
