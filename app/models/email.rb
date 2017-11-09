class Email < ApplicationRecord
  belongs_to :contact
  belongs_to :campaign

  validates :contact, :campaign, presence: true
  validates :contact, uniqueness: { scope: :campaign_id }
end
