class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

has_many :relationships, foreign_key: :following_id


has_many :followings, through: :relationships, source: :follower
has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
has_many :followers, through: :reverse_of_relationships, source: :following



   def already_favorited?(book)
     self.favorites.exists?(book_id: book.id)
   end

   def is_followed_by?(user)
     reverse_of_relationships.find_by(following_id: user.id).present?
   end

def self.looks(search, word)
  if search == "perfect_match"
    @user = User.where("name LIKE?", "#{word}")
  elsif search == "partial_match"
    @user = User.where("name LIKE?","%#{word}%")
  else
      @user = User.all
  end

end

  validates :name, presence: true,length: { in: 2..20 }
  validates :introduction, length: {maximum: 50}
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
