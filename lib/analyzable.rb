module Analyzable
  def average_price(arr)
  	overall_price = 0.0

  	arr.each do |product|
  		overall_price += product.price.to_f
  	end

  	average_price = (overall_price / arr.length).round(2)
  end

  def print_report(all)
  	p all.flatten.to_s
  end

  def count_by_brand(arr)
  	count =  arr.length
  	brand = arr.first.brand

    counter = {brand => count}
  end

  def count_by_name(arr)
  	count = arr.length
  	name = arr.first.name

  	counter = {name => count}
  end
end
