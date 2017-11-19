class Email < ApplicationRecord
  belongs_to :contact
  belongs_to :campaign
  has_many :email_events

  validates :contact, :campaign, presence: true

  def opened!
    email_events.create(event: :open)
  end

  def clicked!
    email_events.create(event: :click)
  end

  def opened_times
    email_events.where(event: :open).count
  end

  def clicks
    email_events.where(event: :click).count
  end

  def sent_times
    Email.where(campaign: campaign, contact: contact).count
  end

  def self.sent_today(user)
    Email.joins(:contact).where("date(emails.created_at) = ? AND contacts.user_id = ?", Date.today, user.id)
  end
end
