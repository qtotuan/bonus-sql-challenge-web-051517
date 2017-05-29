CREATE TABLE IF NOT EXISTS dailyshow (
  id INTEGER PRIMARY KEY,
  year TEXT,
  occupation TEXT,
  show_date TEXT,
  category TEXT,
  name TEXT);

INSERT INTO dailyshow (year, occupation, show_date, category, name)
VALUES ("1999", "actor", "1/18/99", "Acting", "David Alan Grier");
