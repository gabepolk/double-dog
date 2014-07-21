module DoubleDog
  class Item
    attr_reader :name, :price
    attr_accessor :id

    def initialize(id, name, price)
      @id = id
      @name = name
      @price = price
    end
  end
end
