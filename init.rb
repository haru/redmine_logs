# Logs plugin for Redmine
# Copyright (C) 2010  Haruyuki Iida
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
require 'redmine'
require 'admin_menu_hooks'

Redmine::Plugin.register :redmine_logs do
  name 'Redmine Logs plugin'
  author 'Haruyuki Iida'
  author_url 'http://twitter.com/haru_iida'
  url "http://www.r-labs.org/projects/logs" if respond_to?(:url)
  description 'This is a Logs plugin for Redmine'
  version '0.0.5'
  requires_redmine :version_or_higher => '2.1.0'
  
  menu :admin_menu, :redmine_logs, { :controller => 'logs', :action => 'index'}, :caption => :logs
end
