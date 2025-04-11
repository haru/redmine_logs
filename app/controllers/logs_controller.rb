# Logs plugin for Redmine
# Copyright (C) 2010-2023  Haruyuki Iida
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
require 'redmine_logs/log_file'
class LogsController < ApplicationController  
  layout 'admin'
  before_action :require_admin
  before_action :require_correct_path, :except => [:index]

  include RedmineLogs::LogFile

  LOGDIR = "#{Rails.root.to_s}/log"

  def index
    @logs = log_list(LOGDIR)
    @logs.sort{|x, y|x.path <=> y.path}
  end


  def show
    @path = params[:path]
    @log = tail(@path, 20000).join
  end


  def download
    send_file(params[:path])
  end

  def delete
    begin
      File.delete(params[:path])
      redirect_to :action => "index"
    rescue => e
      @error = e
      @logs = log_list(LOGDIR)
      @logs.sort{|x, y|x.path <=> y.path}
      render :action => "index"
    end

  end

  private
  def log_list(path)
    logs = []
    Dir::foreach(path) do |v|
      next if v.start_with?('.') #exlude special path (. and ..) and hidden directories
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

  def require_correct_path
    path = File.expand_path(params[:path])
    unless path.start_with? LOGDIR
      render_403
      return false
    end
    true
  end

  # copy from http://www.hirax.net/diaryweb/2010/03/02.html
  def tail(filename,readLength)
    ary=[]
    f=File.open(filename)
    begin
      f.seek(-readLength,IO::SEEK_END)
    rescue
    end
    while f.gets
      ary<<$_
    end
    f.close
    return ary
  end

end
