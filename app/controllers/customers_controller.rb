require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def add
    # tell view to ask for name
    name = @customers_view.ask_for('name')
    # tell view to ask for address
    address = @customers_view.ask_for('address')
    # create an instance of a customer
    customer = Customer.new(name: name, address: address)
    # give the instance to customer repository
    @customer_repository.create(customer)
  end

  def list
    # ask the customer repo for the customers
    customers = @customer_repository.all
    # tell view to display all the customers
    @customers_view.display(customers)
  end
end
