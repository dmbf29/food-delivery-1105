require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def add
    # tell view to ask for name
    name = @meals_view.ask_for('name')
    # tell view to ask for price
    price = @meals_view.ask_for('price').to_i
    # create an instance of a meal
    meal = Meal.new(name: name, price: price)
    # give the instance to meal repository
    @meal_repository.create(meal)
  end

  def list
    # ask the meal repo for the meals
    meals = @meal_repository.all
    # tell view to display all the meals
    @meals_view.display(meals)
  end
end
