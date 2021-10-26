require_relative "../models/meal"
require_relative "../views/meals_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    #1.Get meals from repo
    meals = @meal_repository.all
    #2. Display them in the terminal
    @meals_view.display(meals)
  end

  def create
    #1. Ask user for name
    name = @meals_view.ask_user_for("name")
    #2. Ask user for a price
    price = @meals_view.ask_user_for("price").to_i
    #3. Instantiate a meal
    meal = Meal.new(name: name, price:price)
    #4. Store in repo
    @meal_repository.add(meal)
  end



end
