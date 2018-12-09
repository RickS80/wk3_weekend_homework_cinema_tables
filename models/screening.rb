require('pry')
require_relative('../db/sql_runner')
require_relative('film')

class Screening

attr_accessor :screening_time
attr_reader :id, :film_id, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @screening_time = options['screening_time']
    @capacity = options['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (film_id, screening_time, capacity) VALUES ($1, $2, $3) RETURNING id"
    values = [@film_id, @screening_time, @capacity]
    SqlRunner.run(sql, values).first['id'].to_i
  end


  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    screening_hash = SqlRunner.run(sql, values)
    result = screening_hash.map { |screening| Screening.new(screening) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, capacity)= ($1, $2)
    WHERE id = $3"
    values = [@screening_time, @capacity, @id]
    SqlRunner.run(sql, values)
  end


end
