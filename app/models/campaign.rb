class Campaign < ApplicationRecord
  include PgSearch
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :tags
  has_many :emails
  belongs_to :user

  pg_search_scope :search_by_title,
                  against: [
                    [:title, 'A']
                  ],
                  using: {
                    tsearch: { prefix: true }
                  },
                  ignoring: :accents

  validates :title, :body, presence: true

  def sent_times
    emails.count
  end

  def opened_times
    emails.sum :opened_times
  end

  def clicks
    emails.sum :clicks
  end

  def send_to_contacts
    contacts.each do |contact|
      email = emails.create(contact: contact)
      CampaignMailer.send_campaign(self, contact, email).deliver_now
    end
  end

  def send_to(contact)
    email = emails.create(contact: contact)
    CampaignMailer.send_campaign(self, contact, email).deliver_now
  end
end
