require_relative "../models/customer"
require_relative "../views/customers_view"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    #1.Get customers from repo
    customers = @customer_repository.all
    #2. Display them in the terminal
    @customers_view.display(customers)
  end

  def add
    #1. Ask user for name
    name = @customers_view.ask_user_for("name")
    #2. Ask user for a address
    address = @customers_view.ask_user_for("address")
    #3. Instantiate a customer
    customer = Customer.new(name: name, address:address)
    #4. Store in repo
    @customer_repository.add(customer)
  end



end
