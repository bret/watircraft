# TODO: support radiogroup
# TODO: migrate this code into Watir
[Watir, FireWatir].each do |mod|
  mod.module_eval <<END
  class TextField # includes Hidden
    def display_value
      value
    end
  end
  class FileField
    def display_value
      value
    end
  end
  class CheckBox
    # returns a boolean
    def display_value
      checked?
    end
  end
  class SelectList
    # Note: currently works for single-select only    
    def display_value
      getSelectedItems[0]
    end
  end
  class Button
    def display_value
      value
    end
  end
  class Element
    def display_value
      text
    end
  end
  class NonControlElement
    def display_value
      text
    end
  end

  class B < NonControlElement
    TAG = 'B'
  end
END
end