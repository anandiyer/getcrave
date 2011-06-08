module ApplicationHelper
  def is_almazom?
    request.server_port == 3006
  end

  def class_name_from_path
    @controller.controller_name+"_"+@controller.action_name
  end
end
