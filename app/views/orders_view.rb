class OrdersView
  # no initialize
  # creating of instances
  # only gets/puts

  def display(orders) # orders is an array of INSTANCES
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1} - #{order.meal.name} | #{order.customer.name} (#{order.customer.address}) | Rider: #{order.employee.username}"
      end
    else
      puts "No orders yet."
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    print '> '
    gets.chomp
  end
end
