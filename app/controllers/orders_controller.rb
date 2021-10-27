require_relative "../views/orders_view"
require_relative "../views/meals_view"
require_relative "../views/customers_view"
require_relative "../views/sessions_view"
require "byebug"

class OrdersController
  def initialize(meal_repo,customer_repo,employee_repo, order_repo)
    @meal_repo = meal_repo
    @customer_repo = customer_repo
    @employee_repo = employee_repo
    @order_repo = order_repo
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @sessions_view = SessionsView.new
    @orders_view = OrdersView.new
  end

  def list_undelivered_orders
    #1.go to the repo and fetch undelivered orders
    orders = @order_repo.undelivered_orders
    #2. display those orders
    @orders_view.display(orders)
  end

  def add
    #1. select a meal (meal repo)
    meal = select_meal
    #2. select a customer (customer repo)
    customer = select_customer
    #3. select a employee (employee repo)
    employee = select_employee
        #4.create the new ordeer
    order = Order.new(meal: meal, customer:customer, employee:employee)
    #store it in the order repo
    @order_repo.create(order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repo.undelivered_orders
    @orders_view.display(undelivered_orders)
  end


  def list_my_undelivered_orders(current_user)
    undelivered_orders = @order_repo.my_undelivered_orders(current_user)
    @orders_view.display(undelivered_orders)
  end


  def mark_as_delivered(current_user)
    #as a rider i want to see my undelivered orders
    list_my_undelivered_orders(current_user)
    #select one
    index = @orders_view.ask_user_for_index
    #get it from the repo
    my_orders = @order_repo.my_undelivered_orders(current_user) #repo
    #mark it as done!
    order = my_orders[index]
    @order_repo.mark_as_delivered!(order) #repo
  end


  private

  def select_meal
    #go into the meals repo
    meals = @meal_repo.all
    #display
    @meals_view.display(meals)
    #ask user to choose
    index = @meals_view.ask_user_for("index").to_i
    #return that meal
    return meals[index - 1]
  end

  def select_customer
    #go into the customers repo
    customers = @customer_repo.all
    #display
    @customers_view.display(customers)
    #ask user to choose
    index = @customers_view.ask_user_for("index").to_i
    #return that customer
    return customers[index - 1 ]
  end

  def select_employee
    #go into the employees repo
    employees = @employee_repo.all
    #display
    @sessions_view.display(employees)
    #ask user to choose
    index = @sessions_view.ask_user_for("index").to_i
    #return that employee
    return employees[index - 1]
  end






end
