module ApplicationHelper
  def check_page(controller_name, action_name)
    controller.controller_name == controller_name && controller.action_name == action_name
  end
end
