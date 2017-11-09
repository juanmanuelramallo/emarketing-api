class CampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :body,
             :created_at,
             :sent_times,
             :opened_times,
             :clicks

 has_many :contacts
 has_many :tags
end
