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

      def create_item(attrs)
        ar_item = Item.create(attrs)
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
      end

      def get_item(item_id)
        ar_item = Item.find_by(id: item_id)
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
      end

      def all_items
        ar_items = Item.all
        ar_items.map do |ar_item|
          DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
        end
      end

      def create_order(attrs)
        ar_order = Order.create(user_id: attrs[:employee_id])
        ar_items = attrs[:items].map do |item|
          Item.find(item.id)
        end

        ar_order.items = ar_items
        DoubleDog::Order.new(ar_order.id, ar_order.user_id, attrs[:items])
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
