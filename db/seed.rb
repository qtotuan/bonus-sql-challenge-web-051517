# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require 'csv'
require 'pry'

def parse_data
  array_of_csv = CSV.read("daily_show_guests.csv")
  # binding.pry
end
