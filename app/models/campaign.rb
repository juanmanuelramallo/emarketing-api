class Campaign < ApplicationRecord
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :tags

  validates :title, :body, presence: true
end
