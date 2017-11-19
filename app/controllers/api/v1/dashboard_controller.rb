module Api::V1
  class DashboardController < ApiController
    before_action :authenticate_user

    def index
      count = params[:count] || 2
      campaigns = current_user.campaigns.spotlighted.last(count).presence || current_user.campaigns.last(count)
      campaigns = ActiveModelSerializers::SerializableResource.new(campaigns).as_json
      emails_opened_today = EmailEvent.where("date(created_at) = ?", Date.today).where(event: :open).count
      emails_sent_today = Email.where("date(created_at) = ?", Date.today).count
      emails_opened_by_day_and_tag = EmailEvent.opened_by_day_and_tag(current_user: current_user)
      render json: { campaigns: campaigns, contactsCount: Tag.count_with_contacts(current_user), emailsOpenedToday: emails_opened_today, emailsSentToday: emails_sent_today, emailsOpenedByDayAndTag: emails_opened_by_day_and_tag }
    end
  end
end