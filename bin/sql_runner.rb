class SQLRunner
  attr_accessor :db

  def initialize(db)
    @db = db
  end

  def fill_seed_data(array)
    array.each do |row|
      # puts row.inspect
      db.execute("INSERT INTO dailyshow (year, occupation, show_date, category, name)
      VALUES (?, ?, ?, ?, ?)", row[0], row[1], row[2], row[3], row[4])
    end
    puts "The data has been inserted into the table."
  end

  def execute_migration_create_table
    sql = File.read('db/migration_create_table.sql')
    execute_sql(sql)
    puts "The table was created."
  end

  def execute_sql(sql)
     sql.scan(/[^;]*;/m).each { |line| @db.execute(line) } unless sql.empty?
  end
end
