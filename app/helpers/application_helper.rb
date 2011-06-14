module ApplicationHelper


  def class_name_from_path
    controller.controller_name+"_"+controller.action_name
  end

  def navigation_selected act_name

    class_name = "not"
    class_name = "selected" if act_name == "nearby" && class_name_from_path == "restaurants_index"
    class_name = "selected" if act_name == "saved" && class_name_from_path == "users_saved"
    class_name = "selected" if act_name == "profile" && class_name_from_path == "users_show"

#    act_name == "nearby" && class_name_from_path == "restaurants_index" ? "selected" : "notselected"

    class_name.to_s


  end

  def stars_class_normalize decimal_data
    dd = (decimal_data * 10).round.to_f / 10
    dd.to_s.gsub(/[.]/, '_')
  end
end
