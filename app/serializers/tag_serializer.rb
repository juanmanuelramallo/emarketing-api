class TagSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :contacts,
             :created_at

  has_many :contacts

  def contacts
    object.contacts.count
  end

  def created_at
    object.created_at.to_s :long
  end
end
