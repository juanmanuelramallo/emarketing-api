class ContactSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :phone,
             :country,
             :city,
             :tag_ids

  has_many :tags

  def tag_ids
    object.tags.map(&:id)
  end
end
