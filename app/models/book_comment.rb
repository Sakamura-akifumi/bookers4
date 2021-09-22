class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  # 1:nの関係となる
  validates :comment, presence: true
end
