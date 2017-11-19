class EmailSerializer < ActiveModel::Serializer
  attributes :id,
             :sent_times,
             :opened_times,
             :clicks

end
