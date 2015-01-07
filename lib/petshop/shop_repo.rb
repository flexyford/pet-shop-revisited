require 'pry-byebug'

module PetShop
  class ShopRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      # TODO: This has to be a JOIN table
      result = Shop.all.to_a()
    end

    def self.find(db, shopid)
      # TODO: This has to be a JOIN table

      Shop.find(shopid)
    end

    def self.save(db, shop_data)
      if shop_data['id'] # Edit Shop

        # Ensure shop exists
        shop = Shop.find(shop_data['id'])

        shop.name = shop_data['name']
        shop.save

        self.find(db, shop_data['id'])
      else
        raise "shop name is required." if shop_data['name'].nil? || shop_data['name'] == ''
        result = Shop.create(name: shop_data['name'])
        self.find(db, result['id'])
      end
    end

    def self.destroy(db, shopid)
      # Delete SQL statement
      Cat.where(:shopid => shopid).delete_all
      Dog.where(:shopid => shopid).delete_all
      Shop.delete(shopid)

    end

  end
end
