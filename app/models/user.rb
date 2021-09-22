class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
#   コメントとuserはn:1となるため
has_many :relationships, foreign_key: :following_id
# フォローする側から伸びている

has_many :followings, through: :relationships, source: :follower
has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
has_many :followers, through: :reverse_of_relationships, source: :following
# user側で2回書いたのでここでもhas_manyを書くということ


   def already_favorited?(book)
     self.favorites.exists?(book_id: book.id)
   end

   def is_followed_by?(user)
     reverse_of_relationships.find_by(following_id: user.id).present?
   end

  validates :name, presence: true,length: { in: 2..20 }
  validates :introduction, length: {maximum: 50}
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
