class EmailEvent < ApplicationRecord
  belongs_to :email

  validates :event, presence: true

  enum event: [:click, :open]

  def self.opened_by_day_and_tag(current_user:, from: Date.today - 7.days, to: Date.today)
    tag_names = Tag.count_with_contacts(current_user).keys
    tag_names.pop
    tags = Tag.where(user: current_user, name: tag_names)
    tags.map do |tag|
      by_date = (from..to).map do |date|
        [date.to_s, EmailEvent.where(event: :open, created_at: date.beginning_of_day..date.end_of_day).joins(email: [contact: :tags]).where("contacts.user_id": current_user.id, "tags.id": tag.id).distinct.count]
      end.to_h

      [tag.name, by_date]
    end.to_h
  end

  def self.opened_today(user)
    emails_opened_today = EmailEvent.joins(email: :contact).where("date(email_events.created_at) = ? AND contacts.user_id = ? AND event = ?", Date.today, user.id, EmailEvent.events[:open])
  end
end
