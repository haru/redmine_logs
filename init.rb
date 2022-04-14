# Logs plugin for Redmine
# Copyright (C) 2010-2017  Haruyuki Iida
# Copyright (C) 2018       Agileware Inc.
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
require File.expand_path('lib/admin_menu_hooks', __dir__)

Redmine::Plugin.register :redmine_logs do
  name 'Redmine Logs plugin'
  author 'Agileware Inc. (Original author: Haruyuki Iida)'
  url 'https://github.com/agileware-jp/redmine_logs'
  description 'This is a Logs plugin for Redmine'
  version '0.1.2-aw'
  requires_redmine :version_or_higher => '3.0.0'

  menu :admin_menu, 'icon redmine-logs', { :controller => 'logs', :action => 'index'}, :caption => :logs
end
