require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata 
	@@data_path = File.dirname(__FILE__) + "/../data/data.csv"

	def self.create(options={})
		brand = options[:brand]
		name = options[:name]
		price = options[:price]
		CSV.open(@@data_path, "ab") do |csv|
			product = Product.new(brand: brand, name: name, price: price)
			csv << ["#{product.id}","#{product.brand}","#{product.name}","#{product.price}" ]
			return product
		end
	end

	def self.all
		all_products = Array.new
		CSV.foreach(@@data_path) do |csv|
			all_products.push(Product.new(id: csv[0], brand: csv[1], name: csv[2], price: csv[3]))
		end
		all_products.shift
		return all_products
	end

	#If no argument is given, reutrns the first product as an instance of product. If an argument given, returns the first n Products in an array.
	def self.first(n = 1)
		products = self.all
		if n == 1
		  product1 = products[0]
		  return Product.new(id: product1.id, brand: product1.brand, name: product1.name, price:product1.price)
		else 
		  first_n_products = Array.new
		  counter = 1
		  n.times do 
		  	product_n = products[counter - 1]
		  	first_n_products.push(Product.new(id: product_n.id, brand: product_n.brand, name: product_n.name, price:product_n.price.to_f))
		  	counter += 1
		  end
		  return first_n_products
		end
	end

	#If no argument is given, reutrns the last product as an instance of product. If an argument given, returns the last n Products in an array.
	def self.last(n = 1)
		products = self.all
		number_of_products = products.length
		if n == 1
		  product1 = products[number_of_products - 1]
		  return Product.new(id: product1.id.to_i, brand: product1.brand, name: product1.name, price:product1.price.to_f)
		else 
		  last_n_products = Array.new
		  counter = 1
		  n.times do 
		  	product_n = products[number_of_products - counter]
		  	last_n_products.push(Product.new(id: product_n.id, brand: product_n.brand, name: product_n.name, price:product_n.price))
		  	counter += 1
		  end
		  return last_n_products
		end
	end

	def self.find(n)	
		if n <= self.all.length 
			return self.all.find { |product| product.id == n }
		else 
			raise Errors::ProductNotFoundError, "This item couldn't be found in the database"
		end
	end

	def self.destroy(n)
		if n - 1 <= self.all.length 
			all_products = self.all
			deleted_product = all_products.find { |product| product.id == n }
			all_products.delete(deleted_product)
				File.delete(@@data_path)
				CSV.open(@@data_path, "ab") do |csv|
					csv << ["id", "brand", "product", "price"]
					all_products.each do |product|
					csv << [product.id, product.brand, product.name, product.price.to_f]
				 	end
				end
				return deleted_product
		else
			raise Errors::ProductNotFoundError, "This item couldn't be found in the database"
		end
	end

	def self.where(options={})
		brand = options[:brand]
		name = options[:name]
		products = self.all
		found_products = Array.new
		products.each do |product|
			if product.brand == brand || product.name == name
				found_products.push(product)
			end
		end
		return found_products
	end

	def update(options={})
		products = Udacidata.all
		new_brand = options[:brand]
		new_name = options[:name]
		new_price = options[:price]

		updated_product = Product.new(id: self.id, brand: new_brand == nil ? self.brand : new_brand, name: new_name == nil ? self.name : new_name, price: new_price == nil ? self.price : new_price)
		products.delete_if{|x| x.id == updated_product.id}.push(updated_product)

		File.delete(@@data_path)
		CSV.open(@@data_path, "ab") do |csv|
			csv << ["id", "brand", "product", "price"]
			products.each do |product|
			csv << [product.id, product.brand, product.name, product.price.to_f]
		 	end
		end

		return updated_product
	end
end
