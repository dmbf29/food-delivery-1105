require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # tell view to ask user for the username
    username = @sessions_view.ask_for('username')
    # tell view to ask user for the password
    password = @sessions_view.ask_for('password')
    # ask the repo for an employee with the username
    employee = @employee_repository.find_by_username(username)
    # check the user's password against the password they gave us
    # if employee&.password == password
    if employee && employee.password == password
      ## LOGIN, welcome message
      @sessions_view.welcome(employee)
      return employee
    else
      ## if not successful, tell them wrong credentials and login again
      @sessions_view.wrong_credentials
      login
    end
  end

end
