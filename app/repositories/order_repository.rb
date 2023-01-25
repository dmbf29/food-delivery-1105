require 'csv'
require_relative '../models/order'

class OrderRepository

  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @orders = []
    @next_id = 1
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # before creating an instance, we need to convert any non-string attributes
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'
      row[:meal_id] = row[:meal_id].to_i
      meal = @meal_repository.find(row[:meal_id])
      row[:meal] = meal

      row[:customer_id] = row[:customer_id].to_i
      customer = @customer_repository.find(row[:customer_id])
      row[:customer] = customer

      row[:employee_id] = row[:employee_id].to_i
      employee = @employee_repository.find(row[:employee_id])
      row[:employee] = employee

      order = Order.new(row)
      @orders << order
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << Order.headers
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |order|
        # csv << order.build_row
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end
