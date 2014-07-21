require 'active_record'

module DoubleDog
  module Databases
    class SQL
      class User < ActiveRecord::Base
        has_many :orders
      end

      class Order < ActiveRecord::Base
        has_many :order_items
        has_many :items, through: :order_items
        belongs_to :user
      end

      class Item < ActiveRecord::Base
        has_many :order_items
        has_many :orders, through: :order_items
      end

      class OrderItem < ActiveRecord::Base
        belongs_to :item
        belongs_to :order
      end

      def persist_user(user)
        ar_user = User.create(username: user.username, password: user.password, admin: user.admin)
        user.id = ar_user.id
      end

      def get_user(user_id)
        ar_user = User.find_by(id: user_id)
      end

      def persist_item(item)
        ar_item = Item.create(name: item.name, price: item.price)
        item.id = ar_item.id
      end

      def get_item(item_id)
        ar_item = Item.find_by(id: item_id)
      end

      def persist_order(order)
        ar_order = Order.create(employee_id: order.employee_id)
        order.items.each do |item|
          persist_item(item)
          OrderItem.create(order_id: ar_order.id, item_id: item.id)
        end
        order.id = ar_order.id
      end

      def get_order(order_id)
        ar_order = Order.find_by(id: order_id)
      end

    end
  end
end
