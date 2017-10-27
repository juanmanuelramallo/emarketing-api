class User < ApplicationRecord
  has_secure_password

  has_many :campaigns
  has_many :contacts
  has_many :tags
end
