class Tag < ApplicationRecord
  has_and_belongs_to_many :contacts

  validates :name, uniqueness: true
end
