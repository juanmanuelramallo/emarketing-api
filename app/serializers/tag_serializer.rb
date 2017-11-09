class TagSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :contacts,
             :created_at

  def contacts
    object.contacts.count
  end

  def created_at
    object.created_at
  end
end
