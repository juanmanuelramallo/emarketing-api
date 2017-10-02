class CampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :body

 has_many :contacts
 has_many :tags
end
