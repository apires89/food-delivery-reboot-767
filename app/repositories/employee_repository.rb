 require 'csv'
require_relative "../models/employee"
require_relative "base_repository"
require 'byebug'

class EmployeeRepository < BaseRepository

  def convert_row(row)
      row[:id] = row[:id].to_i
      Employee.new(row)
  end

  def headers
    ['id', 'username', 'password','role']
  end

  def save_row(element)
    [element.id, element.username,element.password,element.role]
  end

  def find_by_username(username)
    @elements.find {|employee| employee.username == username }
  end



end
