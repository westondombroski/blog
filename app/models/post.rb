class Post < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    belongs_to :user
    validates :title, length: { minimum: 5 }
    validates :body, presence: true
    include PgSearch
    multisearchable :against => [:title, :body]
end