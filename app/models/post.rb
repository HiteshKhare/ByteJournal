class Post < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :comments, dependent: :destroy
  pg_search_scope :search_by_title_and_body, against: [:title, :body]
  validates :title, presence: true
end
