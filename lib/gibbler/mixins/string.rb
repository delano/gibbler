

class String
  unless method_defined? :clear
    def clear
      replace ""
    end
  end
end
