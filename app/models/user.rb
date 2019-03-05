class User < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    validates :image, presence: true
    has_secure_password
    
    mount_uploader :image, ImageUploader
end
