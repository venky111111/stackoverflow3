class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :github]

  def self.create_from_provider_data(access_token)
    
    where(provider: access_token.provider, uid: access_token.uid).first_or_create do |user|
      user.email = access_token.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    
  end

  has_many :post
  has_many :postcomments
  has_many :likes, as: :likeable

end
