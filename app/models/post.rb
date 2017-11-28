class Post < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    belongs_to :user
    validates :title, length: { minimum: 5 }
    validates :body, presence: true
end