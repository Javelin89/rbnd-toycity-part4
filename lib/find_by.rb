class Module
  def create_find_by
    attributes = {:brand => "product[1]", :name => "product[2]"}
    attributes.each do |attribute, location|
      find_by = %Q{
        def find_by_#{attribute}(argument)
          products = CSV.read(File.dirname(__FILE__) + "/data/data.csv")
          products.each do |product|
            if #{location} == argument
              return Product.new(id: product[0], brand: product[1], name: product[2], price: product[3].to_f)
            end
          end
        end
      }
      class_eval(find_by) 
    end
  end
  create_find_by
end
