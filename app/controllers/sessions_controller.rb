require_relative "../views/sessions_view"
class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    #1.Ask the user for username
    username = @sessions_view.ask_user_for("username")
    #2. Ask the user for the password
    password = @sessions_view.ask_user_for("password")
    #3.find the user in the repository
    employee = @employee_repository.find_by_username(username)
    #4.return the employee if password is correct
    return employee if employee && employee.password == password
    #if password is wrongx
    @sessions_view.print_wrong_credentials
    #return to the start
    login
  end
end
