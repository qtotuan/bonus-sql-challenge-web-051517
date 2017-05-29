require 'bundler'
Bundler.require

require 'pry'
require "sqlite3"

require_relative "../lib/queries"
require_relative "../bin/sql_runner"
require_relative "../db/seed"

@db = SQLite3::Database.new 'dailyshow.db'
puts @db.get_first_value 'SELECT SQLITE_VERSION()'
# @db.execute("DROP TABLE IF EXISTS dailyshow;")
@db.execute "CREATE TABLE IF NOT EXISTS dailyshow (
  id INTEGER PRIMARY KEY,
  year TEXT,
  occupation TEXT,
  show_date TEXT,
  category TEXT,
  name TEXT);"


# Create the table and populate with one row
@sql_runner = SQLRunner.new(@db)
@sql_runner.execute_migration_create_table

data_array = parse_data
# @sql_runner.fill_seed_data(data_array)

puts "---------------------"
puts "Who did Jon Stewart have on the Daily Show the most?"
answer = guest_with_most_appearances(@db).flatten
puts "#{answer[0]} with #{answer[1]} appearances."

puts "---------------------"
puts "What was the most popular profession of guest for each year Jon Stewart hosted the Daily Show?"
answer = most_frequent_occupation_by_year(@db)
answer.each do |row|
  puts "#{row[0]}: #{row[2]} #{row[1]}s"
end

puts "---------------------"
puts "What profession was on the show most overall?"
answer = most_frequent_occupation_overall(@db).flatten
puts "There were #{answer[1]} #{answer[0]}s in the Daily Show overall. What a surprise."

puts "---------------------"
puts "How many people did Jon Stewart have on with the first name of Bill?"
answer = first_name_bill(@db)
puts "There were #{answer.length} people with first name 'Bill' on the show."
puts "Their names are:"
puts answer

puts "---------------------"
puts "What dates did Patrick Stewart appear on the show?"
answer = patrick_stewart_dates(@db)
# puts "There were #{answer.length} people with first name 'Bill' on the show."
# puts "Their names are:"
puts answer

puts "---------------------"
puts "Which year had the most guests?"
answer = year_with_most_guests(@db).flatten
puts "In #{answer[0]} there were #{answer[1]} guests on the show."

puts "---------------------"
puts "What was the most popular 'Group' for each year Jon Stewart hosted?"
answer = most_popular_group_by_year(@db)
answer.each do |row|
  puts "#{row[0]}: #{row[1]} with #{row[2]} appearances"
end
