require_relative "../views/meal_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meal_view = MealView.new
  end

  def list
    # grab all the meals from the repository
    meals = @meal_repository.all # array of meal instances
    # give the meals to the view to display
    @meal_view.display(meals)
  end

  def add
    # Ask the view to ask the user for a meal name and store it
    name = @meal_view.ask_for("name")
    # Ask the view to ask the user for a meal price and store it
    price = @meal_view.ask_for("price").to_i
    # create a meal instance
    meal = Meal.new(name: name, price: price)
    # ask the repository to save the meal
    @meal_repository.create(meal)
  end
end
