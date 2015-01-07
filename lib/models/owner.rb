module PetShop
  class Owner < ActiveRecord::Base
    has_many :cats
    has_many :dogs
    validates :username, presence: true, length: {in: 4..12}
    validates :password, presence: true, length: {minimum: 6}, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9])/}
  end
end
