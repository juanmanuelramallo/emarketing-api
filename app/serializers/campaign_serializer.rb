class CampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :body,
             :created_at,
             :sent_times,
             :opened_times,
             :clicks,
             :sent_by_day,
             :opened_by_day,
             :clicks_by_day,
             :spotlighted

 has_many :contacts
 has_many :tags
end
