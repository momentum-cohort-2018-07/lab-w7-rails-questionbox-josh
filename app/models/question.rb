class Question < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :answers, dependent: :destroy
  pg_search_scope :search_question, :against => [:title, :body],
  using: {
      tsearch: { prefix: true } 
    }
end
