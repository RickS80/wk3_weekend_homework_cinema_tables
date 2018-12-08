require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')
require_relative('db/sql_runner')



customer1 = Customer.new({'name' => 'rick', 'funds' => 50})
customer1.save
customer2 = Customer.new({'name' => 'fin', 'funds' => 100})
customer2.save
customer3 = Customer.new({'name' => 'seb', 'funds' => 60})
customer3.save

film1 = Film.new({'title' => 'Jaws', 'price' => 60})
film1.save
film2 = Film.new({'title' => 'Forrest Gump', 'price' => 40})
film2.save
film3 = Film.new({'title' => 'James Bond', 'price' => 30})
film3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket6 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save

screenings1 = Screening.new({'film_id' => film1.id, 'screening_time' => '2018-12-08 10:30:00', 'capacity' => 50})
screenings2 = Screening.new({'film_id' => film1.id, 'screening_time' => '2018-12-08 12:30:00', 'capacity' => 20})
screenings3 = Screening.new({'film_id' => film1.id, 'screening_time' => '2018-12-08 14:30:00', 'capacity' => 30})
screenings1.save
screenings2.save
screenings3.save
# Ticket.all
# Film.all
# Customer.all

# customer1.name = 'gary'
# customer1.update

binding.pry


nil
