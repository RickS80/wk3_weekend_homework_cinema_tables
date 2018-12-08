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



end
