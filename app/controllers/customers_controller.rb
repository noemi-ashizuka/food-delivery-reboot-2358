require_relative "../views/customer_view"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customer_view = CustomerView.new
  end

  def list
    # grab all the customers from the repository
    customers = @customer_repository.all # array of customer instances
    # give the customers to the view to display
    @customer_view.display(customers)
  end

  def add
    # Ask the view to ask the user for a customer name and store it
    name = @customer_view.ask_for("name")
    # Ask the view to ask the user for a customer address and store it
    address = @customer_view.ask_for("address")
    # create a customer instance
    customer = Customer.new(name: name, address: address)
    # ask the repository to save the customer
    @customer_repository.create(customer)
  end
end
