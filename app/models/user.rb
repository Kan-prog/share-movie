class User < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    #validates :image, presence: true
    has_secure_password
    mount_uploader :image, ImageUploader
    
    has_many :reviews
    has_many :favorites
    has_many :likes
    has_many :like_reviews, through: :likes, source: :review
    has_many :stocks
    has_many :stock_reviews, through: :stocks, source: :review
    
    def like(review)
        self.likes.find_or_create_by(review_id: review.id)
    end    
    
    def unlike(review)
        like = self.likes.find_by(review_id: review.id)
        like.destroy if like
    end
    
    def like_review?
        self.like_reviews.include?(review)
    end
    
    def stock(review)
        self.stocks.find_or_create_by(review_id: review.id)
    end    
    
    def unstock(review)
        stock = self.stocks.find_by(review_id: review.id)
        stock.destroy if stock
    end
    
    def stock_review?
        self.stock_reviews.include?(review)
    end
end
