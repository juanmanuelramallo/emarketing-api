class Campaign < ApplicationRecord
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :tags
  belongs_to :user

  validates :title, :body, presence: true
end
