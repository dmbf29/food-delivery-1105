require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def list_undelivered_orders
    # ask the order repo for all the undelivered orders
    orders = @order_repository.undelivered_orders
    # give the orders to the view
    @orders_view.display(orders)
  end

  def add
    # get all meals from the meal repo
    meals = @meal_repository.all
    # display the meals to the user
    @meals_view.display(meals)
    # ask user which meal is in the order (index)
    index = @meals_view.ask_for('number').to_i - 1
    # get the one meal using the index
    meal = meals[index]

    # get all meals from the meal repo
    customers = @customer_repository.all
    # display the customers to the user
    @customers_view.display(customers)
    # ask user which customer is in the order (index)
    index = @customers_view.ask_for('number').to_i - 1
    # get the one customer using the index
    customer = customers[index]

    # get all meals from the meal repo
    employees = @employee_repository.all_riders
    # display the employees to the user
    @employees_view.display(employees)
    # ask user which employee is in the order (index)
    index = @employees_view.ask_for('number').to_i - 1
    # get the one employee using the index
    employee = employees[index]

    # create an instance of an order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # give the instance to the repository
    @order_repository.create(order)
  end

  def list_my_undelivered_orders(employee)
    # get the orders from the order repository
    orders = @order_repository.my_undelivered_orders(employee)
    # give them to the view
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    # we need my undelievered orders from the repo
    orders = @order_repository.my_undelivered_orders(employee)
    # diplaye the orders
    @orders_view.display(orders)
    # ask which order (index)
    index = @orders_view.ask_for('number').to_i - 1
    # get the order we want to deliver
    order = orders[index]
    # mark it as delivered
    @order_repository.mark_as_delivered(order)
  end
end
