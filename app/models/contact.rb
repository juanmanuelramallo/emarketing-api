class Contact < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :first_name, :last_name, :email, presence: true
end
