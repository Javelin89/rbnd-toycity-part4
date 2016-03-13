module Analyzable
  require 'terminal-table'

  def average_price(arr)
  	overall_price = 0.0

  	arr.each do |product|
  		overall_price += product.price.to_f
  	end

  	average_price = (overall_price / arr.length).round(2)
  end

  def print_report(all)
    report = Array.new
  	report.push("Average Price: #{all.average_price(all)}")

    report.push("Inventory by Brand")
      count_by_brand(all).each do |brand, count|
        report.push("- #{brand}: #{count}")
      end

    report.push("Inventory by Name")
      count_by_name(all).each do |name, count|
        report.push("- #{name}: #{count}")
      end

    final_report = String.new
    
    table = Terminal::Table.new do |t|
      report.each do |report|
        t.add_row [report]
      end
    end

    table.style = {:border_x => " ", :border_y => " ", :border_i => " "}

    return table.to_s
  end

  def count_by_brand(arr)
  	brand_count = Hash.new

    arr.each do |product|
      if brand_count.has_key?(product.brand)
        brand_count[product.brand] += 1
      else
        brand_count[product.brand] = 1
      end
    end

   return brand_count
  end

  def count_by_name(arr)
    name_count = Hash.new

    arr.each do |product|
      if name_count.has_key?(product.name)
        name_count[product.name] += 1
      else
        name_count[product.name] = 1
      end
    end
    return name_count
end
end
