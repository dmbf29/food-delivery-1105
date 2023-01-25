class EmployeesView
  # no initialize
  # creating of instances
  # only gets/puts
  def display(employees) # employees is an array of INSTANCES
    if employees.any?
      employees.each_with_index do |employee, index|
        puts "#{index + 1} - #{employee.username} "
      end
    else
      puts "No employees yet."
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    print '> '
    gets.chomp
  end
end
