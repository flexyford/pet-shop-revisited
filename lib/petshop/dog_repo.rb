require 'pry-byebug'

module PetShop
  class DogRepo

    def self.all(db)
      Dog.all.to_a()
    end

    def self.find(db, dog_id)
      Dog.find(dog_id)
    end

    def self.find_all_by_shop(db, shopid)
      Dog.where(:shopid => shopid)
    end

    def self.find_all_by_owner(db, owner_id)
      Dog.where(:owner_id => owner_id)
    end

    def self.save(db, dog_data)
      if dog_data['id'] # Update

        # Ensure dog exists
        dog = find(db, dog_data['id'])
        raise "A valid dog_id is required." if dog.nil?
        raise "A valid owner_id is required." if dog.nil?

        #Assign owner
        if dog_data['adopted'] && dog_data['name']
          dog.name = dog_data['name']
          dog.adopted = dog_data['adopted']
          dog.owner_id = dog_data['owner_id']
        elsif dog_data['name']
          dog.name = dog_data['name']
          dog.owner_id = dog_data['owner_id']
        elsif dog_data['adopted']
          dog.adopted = dog_data['adopted']
          dog.owner_id = dog_data['owner_id']
        end
        dog.save
        self.find(db, dog_data['id'])
      else
        raise "name is required." if dog_data['name'].nil? || dog_data['name'] == ''
        raise "shopid is required." if dog_data['shopid'].nil? || dog_data['shopid'] == ''
        raise "imageurl is required." if dog_data['imageurl'].nil? || dog_data['imageurl'] == ''
        result = Dog.create(name: dog_data['name'], shopid: dog_data['shopid'], imageurl: dog_data['imageurl'])
        self.find(db, result['id'])
      end
    end

    def self.destroy(db, dog_id)
      # Delete SQL statement
      Dog.delete(dog_id)
    end

  end
end
