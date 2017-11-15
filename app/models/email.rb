class Email < ApplicationRecord
  belongs_to :contact
  belongs_to :campaign

  validates :contact, :campaign, presence: true

  def opened!
    update opened_times: opened_times + 1
  end

  def clicked!
    update clicks: clicks + 1
  end
end
