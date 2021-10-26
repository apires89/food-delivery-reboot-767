require_relative "base_view"
class MealsView < BaseView
  def print_element(element,index)
    puts "#{index + 1} -- #{element.name} -- #{element.price}"
  end
end
