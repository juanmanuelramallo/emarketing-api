class Tag < ApplicationRecord
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :contacts
  belongs_to :user

  validates :name, uniqueness: { scope: :user_id }
end
