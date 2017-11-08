class Campaign < ApplicationRecord
  include PgSearch
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :tags
  belongs_to :user

  pg_search_scope :search_by_title,
                  against: [
                    [:title, 'A']
                  ],
                  using: {
                    tsearch: { prefix: true }
                  },
                  ignoring: :accents

  validates :title, :body, presence: true
end
