class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :postcomments, dependent: :destroy
  validates :content,:tittle , presence: true
  has_many :technologies

  extend FriendlyId
  friendly_id :tittle, use: :slugged
   def to_param
        slug
    end
      

end
