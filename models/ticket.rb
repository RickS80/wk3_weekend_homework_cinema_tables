require('pry')
require_relative('../db/sql_runner')
require_relative('film')
require_relative('customer')


class Ticket

attr_accessor :customer_id, :film_id
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket_save = SqlRunner.run(sql, values).first
    @id = ticket_save['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  # binding.pry
  # nil


end
