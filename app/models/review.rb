class Review < ApplicationRecord
    validates :title, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 1000 }
    validates :genre, presence: true, length: { maximum: 20 }
    validates :score, numericality: true
    
    belongs_to :user
    has_many :favorites
    has_many :users, through: :favorites
    has_many :likes
    has_many :like_users, through: :likes, source: :user
    has_many :stocks
    has_many :stock_users, through: :stocks, source: :user
end
