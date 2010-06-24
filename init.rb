require 'redmine'

Redmine::Plugin.register :redmine_logs do
  name 'Redmine Logs plugin'
  author 'Haruyuki Iida'
  url "http://www.r-labs.org/projects/logs" if respond_to?(:url)
  description 'This is a Logs plugin for Redmine'
  version '0.0.1'
  requires_redmine :version_or_higher => '0.9.0'
  
  menu :admin_menu, :redmine_logs, { :controller => 'logs', :action => 'index'}, :caption => :logs
end
