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
			all_products.push(self.new(id: csv[0], brand: csv[1], name: csv[2], price: csv[3]))
		end
		all_products.shift
		return all_products
	end

	#If no argument is given, reutrns the first product as an instance of product. If an argument given, returns the first n Products in an array.
	def self.first(n = 1)
		products = CSV.read(@@data_path)
		if n == 1
		  product1 = products[1]
		  return Product.new(id: product1[0].to_i, brand: product1[1], name: product1[2], price:product1[3].to_f)
		else 
		  first_n_products = Array.new
		  counter = 1
		  n.times do 
		  	product_n = products[counter]
		  	first_n_products.push(Product.new(id: product_n[0].to_i, brand: product_n[1], name: product_n[2], price:product_n[3].to_f))
		  	counter += 1
		  end
		  return first_n_products
		end
	end

	#If no argument is given, reutrns the last product as an instance of product. If an argument given, returns the last n Products in an array.
	def self.last(n = 1)
		products = CSV.read(@@data_path)
		number_of_products = products.length
		if n == 1
		  product1 = products[number_of_products - 1]
		  return Product.new(id: product1[0].to_i, brand: product1[1], name: product1[2], price:product1[3].to_f)
		else 
		  last_n_products = Array.new
		  counter = 1
		  n.times do 
		  	product_n = products[number_of_products - counter]
		  	last_n_products.push(Product.new(id: product_n[0].to_i, brand: product_n[1], name: product_n[2], price:product_n[3].to_f))
		  	counter += 1
		  end
		  return last_n_products
		end
	end

	def self.find(n)
		products = CSV.read(@@data_path)
		product_n = products[n]
		return @found_product = Product.new(id: product_n[0].to_i, brand: product_n[1], name: product_n[2], price:product_n[3].to_f)
	end

	def self.destroy(n)
		products = CSV.read(@@data_path)
		deleted_product = products[n]
		products.delete_at(n)
		products.shift
		File.delete(@@data_path)
		CSV.open(@@data_path, "ab") do |csv|
			csv << ["id", "brand", "product", "price"]
			products.each do |product|
			csv << [product[0], product[1], product[2], product[3].to_f]
		 	end
		end
		return @destroyed_product = Product.new(id: deleted_product[0].to_i, brand: deleted_product[1], name: deleted_product[2], price:deleted_product[3].to_f)
	end

	def self.find_by_brand(brand)
		products = CSV.read(@@data_path)
		products.each do |product|
			if product[1] == brand
				return @found_product = Product.new(id: product[0], brand: product[1], name: product[2], price: product[3].to_f)
			end
		end
	end

	def self.find_by_name(name)
		products = CSV.read(@@data_path)
		products.each do |product|
			if product[2] == name
				return @found_product = Product.new(id: product[0], brand: product[1], name: product[2], price: product[3].to_f)
			end
		end
	end

	def self.where(options={})
		brand = options[:brand]
		name = options[:name]
		products = CSV.read(@@data_path)
		found_products = Array.new
		products.each do |product|
			if product[1] == brand || product[2] == name
				found_products.push(Product.new(id: product[0], brand: product[1], name: product[2], price: product[3].to_f))
			end
		end

		return found_products
	end

	def update(options={})
		products = CSV.read(@@data_path)[1..-1]
		new_brand = options[:brand]
		new_name = options[:name]
		new_price = options[:price]

		updated_product = Product.new(id: self.id, brand: new_brand == nil ? self.brand : new_brand, name: new_name == nil ? self.name : new_name, price: new_price == nil ? self.price : new_price)
		updated_product_arr = [updated_product.id, updated_product.brand, updated_product.name, updated_product.price]
		products[self.id - 1] = updated_product_arr
		p products

		File.delete(@@data_path)
		CSV.open(@@data_path, "ab") do |csv|
			csv << ["id", "brand", "product", "price"]
			products.each do |product|
			csv << [product[0], product[1], product[2], product[3].to_f]
		 	end
		end

		return updated_product
	end
end
