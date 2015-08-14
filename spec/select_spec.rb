describe 'selecting data' do 
  before do
    @db = SQLite3::Database.new(':memory:')
    SQLRunner.make_methods
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_sql_create
    @sql_runner.execute_sql_insert
  end

  it 'selects all of the cats names' do 
    sql = <<-SQL
    SELECT cats.name FROM cats;
    SQL
    expect(@db.execute(sql)).to eq([["Maru"],["Nala"],["Grumpy Cat"], ["Lil Bub"]])
  end

  it 'selects all of the cats breeds' do 
    sql = <<-SQL
    SELECT cats.breed FROM cats;
    SQL
    expect(@db.execute(sql)).to eq([["Scottish Fold"], ["Siamese"], ["Ragdoll"], ["Dwarf"]])
  end

  it 'selects all of the female cats and returns their names' do
    sql = <<-SQL
    SELECT cats.name FROM cats WHERE cats.gender='F';
    SQL
    expect(@db.execute(sql)).to eq([["Nala"], ["Grumpy Cat"], ["Lil Bub"]])
  end

  it 'selects all of the declawed cats and returns their names' do 
    sql = <<-SQL
    SELECT cats.name FROM cats WHERE cats.declawed=1;
    SQL
    expect(@db.execute(sql)).to eq([["Grumpy Cat"], ["Lil Bub"]])
  end

  it 'selects all the friendly cats and returns their names' do 
    sql = <<-SQL
    SELECT cats.name FROM cats WHERE cats.temperment='friendly';
    SQL
    expect(@db.execute(sql)).to eq([["Grumpy Cat"], ["Lil Bub"]])
  end

  it 'selects all of the cats over 2 years old and returns their names and ages' do 
    sql = <<-SQL
    SELECT cats.name, cats.age FROM cats WHERE cats.age > 2;
    SQL
    expect(@db.execute(sql)).to eq([["Maru", 6], ["Nala", 3], ["Lil Bub", 3]])
  end
end