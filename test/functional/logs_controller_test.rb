require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
#require File.dirname(__FILE__) + '/../test_helper'

class LogsControllerTest < Redmine::ControllerTest
  fixtures :projects, :users, :roles, :members
  LOGDIR = "#{Rails.root.to_s}/log"
  def setup
    User.current = nil
    @request.session[:user_id] = 1

    File.open("#{LOGDIR}/foo.log", "w") do |f|
      f.puts("Hello, World!")
      f.puts("Hello, World!")
      f.puts("Hello, World!")
    end
  end

  def test_index
    get :index
    assert_response :success
  end

  def test_download
    get :download, params: {path: "#{LOGDIR}/foo.log"}
    assert_response :success
  end

  def test_show
    post :show, params: {path: "#{LOGDIR}/foo.log"}
    assert_response :success
  end
end
