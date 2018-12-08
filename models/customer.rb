require('pry')
require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')

class Customer

attr_accessor :name, :funds
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer_save = SqlRunner.run(sql, values).first
    @id = customer_save['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds)= ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.* FROM
    films INNER JOIN tickets ON
    films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    film_hash = SqlRunner.run(sql, values)
    film_hash.map { |film| Film.new(film)}
  end

  def ticket_count
    films.count
  end

  def buy_film_ticket(film)
    ticket_price = film.price
    if @funds >= ticket_price
      @funds -= ticket_price
    else p "you need more money to watch this film"
    end
  end


end
