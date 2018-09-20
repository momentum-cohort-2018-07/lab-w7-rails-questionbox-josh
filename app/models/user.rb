class User < ApplicationRecord
  include PgSearch
  has_secure_token :api_token
  has_secure_password
  has_many :questions
  has_many :answers
  has_one_attached :profile_pic
  validates :username, presence: true, uniqueness: true
  pg_search_scope :search_name, :against => [:first_name, :last_name, :username],
  using: {
      tsearch: { prefix: true } 
    }
end
