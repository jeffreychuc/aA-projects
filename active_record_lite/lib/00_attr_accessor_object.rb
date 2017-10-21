class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |var_name|
      define_method(var_name) do
        instance_variable_get("@#{var_name}")
      end

      # above code is setting up this for each variable
      # def var_name
      #   @var_name
      # end
      # ...

      define_method("#{var_name}=") do |arg|
        instance_variable_set("@#{var_name}", arg)
      end

      # above code is setting up this for each variable
      # def var_name=(arg)
      #   @var_name = arg
      # end
      # ...
    end

  end
end
