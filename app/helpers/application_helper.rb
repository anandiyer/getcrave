module ApplicationHelper


  def class_name_from_path
    controller.controller_name+"_"+controller.action_name
  end

  def title action_and_controller_name
    if action_and_controller_name == "menu_items_show"
      str = @menu_item.name
    elsif action_and_controller_name == "menu_items_index"
      str = @restaurant.name
    elsif action_and_controller_name.include?("users_")
      str = @user.user_name+"'s profile"
    else
      str = "crave - so what's good here?"
    end
    "сrave - #{str}"
  end

  def navigation_selected act_name

    class_name = "not"
    class_name = "selected" if act_name == "nearby" && class_name_from_path == "menu_items_location"
    class_name = "selected" if act_name == "saved" && class_name_from_path == "users_saved"
    class_name = "selected" if act_name == "profile" && class_name_from_path == "users_show"

#    act_name == "nearby" && class_name_from_path == "restaurants_index" ? "selected" : "notselected"

    class_name.to_s
  end

  def stars_class_normalize decimal_data
    if (decimal_data.to_i != 0)
      dd = (decimal_data * 10).round.to_f / 10
      decimal_data = dd.to_f
      
      if (decimal_data >= 0.0 && decimal_data <= 0.2)
        decimal_data = 0.0
      elsif (decimal_data >= 0.3 && decimal_data <= 0.7)
        decimal_data = 0.5
      elsif (decimal_data >= 0.8 && decimal_data <= 1.2)
        decimal_data = 1.0
      elsif (decimal_data >= 1.3 && decimal_data <= 1.7)
        decimal_data = 1.5
      elsif (decimal_data >= 1.8 && decimal_data <= 2.2)
        decimal_data = 2.0
      elsif (decimal_data >= 2.3 && decimal_data <= 2.7)
        decimal_data = 2.5
      elsif (decimal_data >= 2.8 && decimal_data <= 3.2)
        decimal_data = 3.0
      elsif (decimal_data >= 3.3 && decimal_data <= 3.7)
        decimal_data = 3.5
      elsif (decimal_data >= 3.8 && decimal_data <= 4.2)
        decimal_data = 4.0
      elsif (decimal_data >= 4.3 && decimal_data <= 4.7)
        decimal_data = 4.5
      elsif (decimal_data >= 4.8 && decimal_data <= 5.0)
        decimal_data = 5.0
      end
    end
    decimal_data.to_s.gsub(/[.]/, '_')
  end
end
