class User < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    #validates :image, presence: true
    has_secure_password
    
    #mount_uploader :image, ImageUploader
end
