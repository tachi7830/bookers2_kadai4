class Book < ApplicationRecord
  belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  validates :rate, presence: true
  validates :rate, numericality: {
    #rateカラムでは整数のみ許可したい
    #only_integer: true,
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0,
  }
  
  def Book.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end
  
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
