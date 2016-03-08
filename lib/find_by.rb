class Module
  def create_finder_methods(*attributes)
    brand_name_location = Hash[brand = product[1], name = product[2]]

    brand_name_location.each do |item, position|
    	self.send(:define_method, "find_by_#{item}(options={}") do
    		item = options[:item]
    		products = CSV.read(@@data_path)
			products.each do |product|
				if position == item
					return @found_product = Product.new(id: product[0], brand: product[1], name: product[2], price: product[3].to_f)
				end
			end
		end
    # Hint: Remember attr_reader and class_eval
  end
end
