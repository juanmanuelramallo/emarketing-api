class User < ApplicationRecord
  has_secure_password

  has_many :campaigns
  has_many :contacts
  has_many :tags

  validates :name, :last_name, :email, presence: true
  validates :email, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, presence: { length: 6 }
  validates :email, uniqueness: true

  after_create :create_default_tags

  private

  def create_default_tags
    ["Músico", "Deporte", "Arte", "Cine", "Tecnología"].each { |tag_name| self.tags.create name: tag_name }
  end
end
