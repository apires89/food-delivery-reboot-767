class Order
  attr_reader :meal, :customer, :delivered
  attr_accessor :id, :employee
  def initialize(attributes={})
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
    @id = attributes[:id]
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
