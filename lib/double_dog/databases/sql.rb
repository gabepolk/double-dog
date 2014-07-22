require 'active_record'

module DoubleDog
  module Database
    class SQL
      class User < ActiveRecord::Base
        has_many :orders
        has_one :session
      end

      class Item < ActiveRecord::Base
        has_many :order_items
        has_many :orders, through: :order_items
      end

      class Order < ActiveRecord::Base
        belongs_to :user
        has_many :order_items
        has_many :items, through: :order_items
      end

      class OrderItem < ActiveRecord::Base
        belongs_to :item
        belongs_to :order
      end

      class Session < ActiveRecord::Base
        belongs_to :user
      end

      def create_user(attrs)
        ar_user = User.create(attrs)
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def get_user(user_id)
        ar_user = User.find_by(id: user_id)
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def create_session(attrs)
        ar_session = Session.create(attrs)
      end

      def get_user_by_username(username)
        ar_user = User.find_by(username: username)
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def get_user_by_session_id(session_id)
        ar_user = Session.find_by(id: session_id).user
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def create_item(item)
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

      def reset_tables
        Item.destroy_all
        User.destroy_all
        Order.destroy_all
        OrderItem.destroy_all
        Session.destroy_all
      end

    end
  end
end
