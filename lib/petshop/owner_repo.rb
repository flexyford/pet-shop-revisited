require 'pry-byebug'

module PetShop
  class OwnerRepo

    def self.all(db)
      Owner.all.to_a()
    end

    def self.find(db, owner_id)
      Owner.find(owner_id)
    end

    # find user by username. Intended to be used when
    # someone tries to sign in.
    def self.find_by_name db, username
      Owner.find_by(username: username)
    end

    def self.save(db, owner_data)
      if owner_data['id'] # Edit owner

        # Ensure owner exists
        owner = find(db, owner_data['id'])

        if owner_data['username'] # Update Owner Name
          owner.username = owner_data['username']
        end

        if owner_data['password'] # Update Owner Password
          owner.password = owner_data['password']
        end
        owner.save
        self.find(db, owner_data['id'])
      else
        result = Owner.create!(username: owner_data['username'], password: owner_data['password'])
        self.find(db, result['id'])
      end
    end

    def self.destroy(db, owner_id)
      # Delete SQL statement
      Cat.where(:owner_id => owner_id).update_all(:owner_id => nil, :adopted => 'false')
      Dog.where(:owner_id => owner_id).update_all(:owner_id => nil, :adopted => 'false')

      Owner.delete(owner_id)
    end

  end
end
