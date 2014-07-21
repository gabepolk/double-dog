require 'active_record'

module DoubleDog
  module Databases
    class SQL
      class User < ActiveRecord::Base
        has_many :orders
      end

      class Order < ActiveRecord::Base
        has_many :items
        belongs_to :user
      end

      class Item < ActiveRecord::Base
        belongs_to :order
      end

      def persist_user(user)
        ar_user = User.create(username: user.username, password: user.password, admin: user.admin)
      end
    end
  end
end
