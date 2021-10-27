require 'csv'
require_relative "../models/order"
require "byebug"

class OrderRepository
  def initialize(csv_file,meal_repository,customer_repository,employee_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @orders
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def find(id)
    @orders.find{|order| order.id == id}
  end

  def undelivered_orders
    @orders.reject {|order| order.delivered?}
  end

  def my_undelivered_orders(employee)
    @orders.select {|order| order.employee == employee && !order.delivered?}
  end

  def mark_as_delivered!(order)
    order.deliver!
    save_csv
  end







  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      #convert some rows to integer[]
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      #find the meal,employee and customer from the repo
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      #create new order with row with updated values and push it to array
      @orders << Order.new(row)
    end
    @next_id = @orders.last.id + 1
  end

  def save_csv
    csv_options = {col_sep: ',', force_quotes: true, quote_char: '"'}
    CSV.open(@csv_file, "wb", csv_options) do |csv|
      csv << %w(id delivered meal_id customer_id employee_id)
      @orders.each do |order|
        csv << [order.id,order.delivered,order.meal.id,order.customer.id,order.employee.id]
      end
    end

  end



end