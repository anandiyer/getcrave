module ApplicationHelper
  def is_almazom?
    request.server_port == 3006
  end
end
