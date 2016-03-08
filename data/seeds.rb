require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  @id = 1
  data_path = File.dirname(__FILE__) + "/../data/data.csv"
  CSV.open(data_path, "ab") do |csv|
  	10.times do
  		brand = Faker::Company.name
  		name = Faker::Commerce.product_name
  		price = Faker::Commerce.price
		csv << ["#{@id}","#{brand}","#{name}","#{price}"]
		@id += 1
  	end
  end
end
