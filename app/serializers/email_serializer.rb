class EmailSerializer < ActiveModel::Serializer
  attributes :id,
             :sent_times,
             :opened_times,
             :clicks

  def sent_times
    Email.where(campaign: object.campaign, contact: object.contact).count
  end
end
