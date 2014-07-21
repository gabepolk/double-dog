class Order < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :employee_id
    end
  end
end
