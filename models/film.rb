require('pry')
require_relative('../db/sql_runner')
require_relative('customer')
require_relative('ticket')


class Film

attr_accessor :title, :price
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    film_save = SqlRunner.run(sql, values).first
    @id = film_save['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def update()
    sql = "UPDATE films SET (title, price)= ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM
    customers INNER JOIN tickets ON
    customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    customer_hash = SqlRunner.run(sql, values)
    customer_hash.map { |customer| Customer.new(customer)}
  end

  def customer_count
    customers.count
  end

  def screenings
    sql = "SELECT screenings.* FROM
    screenings INNER JOIN films ON
    films.id = screenings.film_id
    WHERE screenings.film_id = $1"
    values = [@id]
    screenings_hash = SqlRunner.run(sql, values)
    screenings_hash.map { |screening| Screening.new(screening)}
  end







end
