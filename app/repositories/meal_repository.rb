require 'csv'
require_relative "../models/meal"
require_relative "base_repository"

class MealRepository < BaseRepository

  def convert_row(row)
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      Meal.new(row)
  end

  def headers
    ['id', 'name', 'price']
  end

  def save_row(element)
    [element.id, element.name,element.price]
  end


end
