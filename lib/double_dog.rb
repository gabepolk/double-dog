require 'pry-byebug'

module DoubleDog
  def self.db
    @__db_instance ||= Database::SQL.new
  end
end

require_relative 'double_dog/entities/item.rb'
require_relative 'double_dog/entities/user.rb'
require_relative 'double_dog/entities/order.rb'

require_relative 'double_dog/databases/in_memory.rb'
require_relative 'double_dog/databases/sql.rb'

require_relative 'double_dog/scripts/transaction_script.rb'
require_relative 'double_dog/scripts/create_account.rb'
require_relative 'double_dog/scripts/create_item.rb'
require_relative 'double_dog/scripts/sign_in.rb'
require_relative 'double_dog/scripts/see_all_orders.rb'
require_relative 'double_dog/scripts/create_order.rb'

require_relative '../config/environments.rb'
