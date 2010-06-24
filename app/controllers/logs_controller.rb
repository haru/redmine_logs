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
