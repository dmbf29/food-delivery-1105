class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    # what do we need here? -> controllers
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.login
      while @employee
        if @employee.manager?
          # if they are a manager
          choice = display_manager_menu
          print `clear`
          manager_action(choice)
        else
        # if they are a rider
          choice = display_rider_menu
          print `clear`
          rider_action(choice)
        end
      end
    end
  end

  private

  def display_manager_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - Create a meal"
    puts "2 - Show all meals"
    puts "3 - Create a customer"
    puts "4 - Show all customers"
    puts "5 - Show all undelivered orders"
    puts "6 - Create an order"
    puts "9 - Quit"
    puts "0 - Logout"
    print "> "
    gets.chomp.to_i
  end

  def display_rider_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - Display my orders"
    puts "2 - Mark order as delivered"
    puts "9 - Quit"
    puts "0 - Logout"
    print "> "
    gets.chomp.to_i
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 9 then quit
    when 0 then @employee = nil
    else
      puts "Try again..."
    end
  end

  def rider_action(choice)
    case choice
    when 1 then @orders_controller.list_my_undelivered_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 9 then quit
    when 0 then @employee = nil
    else
      puts "Try again..."
    end
  end

  def quit
    @running = false
    @employee = nil
  end
end
