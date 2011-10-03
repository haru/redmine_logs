class AdminMenuHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = { })
    stylesheet_link_tag('logs.css', :plugin => 'redmine_logs')
  end
end
