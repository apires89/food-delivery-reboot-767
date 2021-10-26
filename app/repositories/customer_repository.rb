require 'csv'
require_relative "../models/customer"
require_relative "base_repository"

class CustomerRepository < BaseRepository

  def convert_row(row)
      row[:id] = row[:id].to_i
      Customer.new(row)
  end

  def headers
    ['id', 'name', 'address']
  end

  def save_row(element)
    [element.id, element.name,element.address]
  end


end
