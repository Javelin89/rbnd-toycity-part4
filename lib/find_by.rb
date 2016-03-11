class Module
  def create_find_by
    attributes = ["brand", "name"]
    attributes.each do |attribute|
      find_by = %Q{
        def find_by_#{attribute}(argument)
          products = self.all
          products.each do |product|
            if product.#{attribute} == argument
              return product
            end
          end
        end
      }
      class_eval(find_by) 
    end
  end
  create_find_by
end
