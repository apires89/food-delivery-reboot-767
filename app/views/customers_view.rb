require_relative "base_view"
class CustomersView < BaseView
  def print_element(element,index)
    puts "#{index + 1} -- #{element.name} -- #{element.address}"
  end
end
