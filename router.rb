class Router
  def initialize(meals_controller,customers_controller,sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
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
    puts "5- Add new order"
    puts "6- List all undelivered orders"
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
    puts "7- Log out"
    puts "9 - Quit"
    print "> "
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.create
    when 3 then @customers_controller.list
    when 4 then @customers_controller.create
    when 5 then puts "TODO"
    when 6 then puts "TODO"
    when 7 then logout!
    when 9 then stop!
    else
      puts "Try again..."
    end
  end

  def rider_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.create
    when 3 then @customers_controller.list
    when 4 then @customers_controller.create
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
