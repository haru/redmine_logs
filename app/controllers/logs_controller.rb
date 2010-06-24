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
require 'log_file'
class LogsController < ApplicationController
  unloadable
  layout 'base'
  before_filter :require_admin

  include RedmineLogs::LogFile
  
  LOGDIR = "#{RAILS_ROOT}/log"

  def index
    @logs = log_list(LOGDIR)
  end


  def show
  end


  def download
    send_file(params[:path])

  end

  private
  def log_list(path)
    logs = []
    Dir::foreach(path) do |v|
      next if v == "." or v == ".."
      if path =~ /\/$/
        v = path + v
      else
        v = path + "/" + v
      end
      
      if FileTest::directory?(v)
        logs = logs + log_list(v)
      else
        logs << LogFile.new(v)
      end
    end
    logs
  end
end
