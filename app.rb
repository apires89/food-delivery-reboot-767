require_relative "router"
require_relative "app/controllers/meals_controller"
require_relative "app/repositories/meal_repository"
require_relative "app/controllers/customers_controller"
require_relative "app/repositories/customer_repository"

meal_repo = MealRepository.new(File.join(__dir__, 'data/meals.csv'))
meals_controller = MealsController.new(meal_repo)

customer_repo = CustomerRepository.new(File.join(__dir__, 'data/customers.csv'))
customers_controller = CustomersController.new(customer_repo)


router = Router.new(meals_controller,customers_controller)
router.run
