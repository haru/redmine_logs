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

  CATEGORIES = [
    { id: 'production',  name: :label_log_category_production },
    { id: 'puma',        name: :label_log_category_puma },
    { id: 'development', name: :label_log_category_development },
    { id: 'test',        name: :label_log_category_test },
    { id: 'error',       name: :label_log_category_error },
    { id: 'setup',       name: :label_log_category_setup },
    { id: 'others',      name: :label_log_category_others }
  ].freeze

  def index
    @logs = log_list(LOGDIR)
    @logs.sort! { |x, y| x.path <=> y.path }

    settings = Setting.plugin_redmine_logs || {}
    @view_mode = settings['view_mode'].presence || 'grouped'

    # Build categorized log map
    @categorized_logs = {
      'production'  => [],
      'puma'        => [],
      'development' => [],
      'test'        => [],
      'error'       => [],
      'setup'       => [],
      'others'      => []
    }

    @logs.each do |log|
      category = categorize_log(log.path)
      @categorized_logs[category] << log
    end

    @selected_tab = params[:tab].presence || 'production'
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
      @logs.sort! { |x, y| x.path <=> y.path }
      render :action => "index"
    end
  end

  private

  def categorize_log(path)
    base = File.basename(path).downcase

    if base.start_with?('production')
      'production'
    elsif base.start_with?('puma')
      'puma'
    elsif base.start_with?('development')
      'development'
    elsif base.start_with?('test')
      'test'
    elsif base.include?('setup') || base.include?('service')
      'setup'
    elsif (base.include?('error') || base.include?('err')) && !base.start_with?('puma')
      'error'
    else
      'others'
    end
  end

  def log_list(path)
    logs = []
    Dir.foreach(path) do |v|
      next if v.start_with?('.') # exclude special path (. and ..) and hidden directories
      full_path = File.join(path, v)

      if FileTest.directory?(full_path)
        logs += log_list(full_path)
      else
        logs << LogFile.new(full_path)
      end
    end
    logs
  end

  def require_correct_path
    path = File.expand_path(params[:path])
    unless path.start_with?(LOGDIR)
      render_403
      return false
    end
    true
  end

  def tail(filename, read_length)
    ary = []
    File.open(filename) do |f|
      begin
        f.seek(-read_length, IO::SEEK_END)
      rescue
      end
      while (line = f.gets)
        ary << line
      end
    end
    ary
  end
end
