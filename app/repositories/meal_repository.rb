require 'csv'

class MealRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # before creating an instance, we need to convert any non-string attributes
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i

      @meals << Meal.new(row)
    end
    @next_id = @meals.any? ? @meals.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << Meal.headers
      @meals.each do |meal|
        # csv << [meal.id, meal.name, meal.price]
        csv << meal.build_row
      end
    end
  end
end
