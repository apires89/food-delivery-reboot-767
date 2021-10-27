class Router
  def initialize(meals_controller,customers_controller,sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
    @current_user = nil
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          route_manager_action
        else
          route_rider_action
        end
      end
      print `clear`
    end
  end

  private

  def route_manager_action
    print_manager_menu
    choice = gets.chomp.to_i
    manager_action(choice)
  end

  def route_rider_action
    print_rider_menu
    choice = gets.chomp.to_i
    rider_action(choice)
  end

  def print_manager_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2- Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "5- List all undelivered orders"
    puts "6- Add a new order"
    puts "7- Log out"
    puts "9 - Quit"
    print "> "
  end

  def print_rider_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2- Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "5- List all undelivered orders"
    puts "6- Mark order as delivered"
    puts "7- Log out"
    puts "9 - Quit"
    print "> "
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 7 then logout!
    when 9 then stop!
    else
      puts "Try again..."
    end
  end

  def rider_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.mark_as_delivered(@current_user)
    when 7 then logout!
    when 9 then stop!
    else
      puts "Try again..."
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end


end
