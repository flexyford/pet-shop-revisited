module PetShop
  class Dog < ActiveRecord::Base
    belongs_to :shop, :foreign_key => 'shopid'
    belongs_to :owner
  end
end
