module DoubleDog
  class Order
    attr_reader :employee_id, :items
    attr_accessor :id

    def initialize(id, employee_id, items)
      @id = id
      @employee_id = employee_id
      @items = items
    end

    def total
      items.reduce(0) {|sum, item| sum + item.price }
    end
  end
end
