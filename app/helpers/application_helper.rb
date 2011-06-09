module ApplicationHelper


  def class_name_from_path
    @controller.controller_name+"_"+@controller.action_name
  end

  def stars_class_normalize decimal_data
    decimal_data.to_s.gsub(/[.]/, '_')
  end
end
