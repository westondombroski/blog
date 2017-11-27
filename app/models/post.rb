class Post < ApplicationRecord
    validates :title, length: { minimum: 5 }
    validates :body, presence: true
end