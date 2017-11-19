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
  before_save :fix_images_size

  scope :spotlighted, -> { where spotlighted: true }

  def sent_times
    emails.count
  end

  def opened_times
    emails.sum(&:opened_times)
  end

  def clicks
    emails.sum(&:clicks)
  end

  def sent_by_day
    emails.group("date(created_at)").count
  end

  def opened_by_day
    emails.joins(:email_events).where("email_events.event": :open).group("date(email_events.created_at)").count
  end

  def clicks_by_day
    emails.joins(:email_events).where("email_events.event": :click).group("date(email_events.created_at)").count
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

  private

  def fix_images_size
    self.body = self.body.gsub("<img ", "<img style='max-width: 100%; max-height: 600px' ")
  end
end
