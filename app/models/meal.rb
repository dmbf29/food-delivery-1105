class Meal
  attr_reader :name
  attr_accessor :id, :price # reader and writer

  def initialize(attibutes = {})
    @id = attibutes[:id] # integer
    @name = attibutes[:name] # string
    @price = attibutes[:price] # integer
  end

  def build_row
    [@id, @name, @price]
  end

  # meal.headers
  # Meal.headers
  def self.headers
    ['id', 'name', 'price']
  end
end

# meal =  Meal.new(name: 'pizza')
# meal.price # reader
# meal.price = 500 # writer
# meal.id = 1
