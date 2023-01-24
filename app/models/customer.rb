class Customer
  attr_reader :name
  attr_accessor :id, :address # reader and writer

  def initialize(attibutes = {})
    @id = attibutes[:id] # integer
    @name = attibutes[:name] # string
    @address = attibutes[:address] # integer
  end

  def build_row
    [@id, @name, @address]
  end

  # meal.headers
  # Meal.headers
  def self.headers
    ['id', 'name', 'address']
  end
end

# meal =  Meal.new(name: 'pizza')
# meal.address # reader
# meal.address = 500 # writer
# meal.id = 1
