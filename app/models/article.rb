class Article < ApplicationRecord
  include Visible
  include Paginatable

  has_many :comments, dependent: :destroy

  validates :title, presence: true
end
