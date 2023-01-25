require 'csv'
require_relative '../models/employee'

class EmployeeRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @employees
  end

  def all_riders
    @employees.select do |employee|
      employee.rider?
    end
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # before creating an instance, we need to convert any non-string attributes
      row[:id] = row[:id].to_i

      @employees << Employee.new(row)
    end
  end
end
