class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [ :google ]

   protected
   def self.find_for_google(auth)
     User.find_by(email: auth.info.email) ||  User.create({
       uid: auth.uid,
       email: auth.info.email,
       token: auth.credentials.token,
       provider: auth.provider,
       password: Devise.friendly_token[0, 20]
     })
   end
end
