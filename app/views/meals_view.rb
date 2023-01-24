class MealsView
  # no initialize
  # creating of instances
  # only gets/puts
  def display(meals) # meals is an array of INSTANCES
    if meals.any?
      meals.each_with_index do |meal, index|
        puts "#{index + 1} - #{meal.name} ¥#{meal.price}"
      end
    else
      puts "No meals yet."
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    print '> '
    gets.chomp
  end
end
