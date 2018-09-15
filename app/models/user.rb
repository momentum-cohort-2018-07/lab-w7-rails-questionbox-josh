class User < ApplicationRecord
  has_secure_token :api_token
  has_secure_password
  has_many :questions
  has_many :answers
  has_one_attached :profile_pic

  def profile_pic_url
    url_for(self.profile_pic)
  end
end
