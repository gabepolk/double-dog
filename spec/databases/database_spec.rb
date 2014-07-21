require 'spec_helper'

shared_examples 'a database' do
  let(:db) { described_class.new }

  describe 'users' do
    it 'persists and gets' do
      user = DoubleDog::User.new(nil, 'Dan', '123')
      db.persist_user(user)
      expect(user.id).to_not be_nil

      retrieved_user = db.get_user(user.id)
      expect(retrieved_user.username).to eq('Dan')
      expect(retrieved_user.password).to eq('123')
      expect(retrieved_user.admin).to eq(false)
    end
  end

  describe 'items' do
    it 'persists and gets' do
      item = DoubleDog::Item.new(nil, 'burger', 18)
      db.persist_item(item)
      expect(item.id).to_not be_nil

      retrieved_item = db.get_item(item.id)
      expect(retrieved_item.name).to eq('burger')
      expect(retrieved_item.price).to eq(18)
    end
  end

  describe 'order' do
    it 'persists and gets' do
      item1 = DoubleDog::Item.new(nil, 'burger', 18)
      item2 = DoubleDog::Item.new(nil, 'fries', 2)
      order = DoubleDog::Order.new(nil, 1, [item1, item2])
      db.persist_order(order)
      expect(order.id).to_not be_nil

      retrieved_order = db.get_order(order.id)
      expect(retrieved_order.employee_id).to eq(1)
      expect(retrieved_order.items.count).to eq(2)
      expect(retrieved_order.items[0].name).to eq('burger')
      expect(retrieved_order.items[1].name).to eq('fries')
    end
  end

end

describe DoubleDog::Databases::InMemory do
  it_behaves_like 'a database'
end

describe DoubleDog::Databases::SQL do
  it_behaves_like 'a database'
end
