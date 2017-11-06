class CampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :body,
             :created_at

 has_many :contacts
 has_many :tags
end
