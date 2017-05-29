# Write methods that return SQL queries for each part of the challeng here

def guest_with_most_appearances(db)
  db.execute("SELECT name, COUNT(name) FROM dailyshow GROUP BY name ORDER BY COUNT(name) DESC LIMIT 1")
end

def most_frequent_occupation_overall(db)
  db.execute("SELECT occupation, COUNT(occupation) FROM dailyshow
  GROUP BY occupation, year
  ORDER BY COUNT(occupation) DESC LIMIT 1")
end

def most_frequent_occupation_by_year(db)
  sql = <<-SQL
    SELECT year, occupation, MAX(occupation_count)
    FROM (SELECT year, occupation, COUNT(occupation)  AS occupation_count
    FROM dailyshow
    GROUP BY year, occupation
    ORDER BY year, occupation_count DESC)
    GROUP BY year
  SQL
  db.execute(sql)
end

def first_name_bill(db)
  answer = db.execute("SELECT * FROM dailyshow WHERE name LIKE 'Bill %'")
  people = []
  answer.each do |person_array|
    people << person_array[5]
  end
  people.uniq!
end

def patrick_stewart_dates(db)
  db.execute("SELECT show_date FROM dailyshow WHERE name = 'Patrick Stewart'")
end

def year_with_most_guests(db)
  db.execute("SELECT year, COUNT(name) FROM dailyshow GROUP BY year ORDER BY COUNT(name) DESC LIMIT 1")
end

def most_popular_group_by_year(db)
  sql = <<-SQL
    SELECT year, category, MAX(category_count)
    FROM (SELECT year, category, COUNT(category) as category_count
    FROM dailyshow
    GROUP BY year, category
    ORDER BY year, category_count DESC)
    GROUP BY year;
  SQL
  db.execute(sql)
end

# SELECT year, occupation, COUNT(occupation)
# FROM dailyshow  GROUP BY year, occupation
# HAVING COUNT (occupation)=(
# SELECT MAX(mycount)
# FROM (
# SELECT occupation, COUNT(occupation) mycount
# FROM dailyshow
# GROUP BY occupation));
