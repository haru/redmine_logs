require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
#require File.dirname(__FILE__) + '/../test_helper'

class LogsControllerTest < ActionController::TestCase
  fixtures :projects, :users, :roles, :members
  LOGDIR = "#{Rails.root.to_s}/log"
  def setup
    @request    = ActionController::TestRequest.new
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
    get :download, path: "#{LOGDIR}/foo.log"
    assert_response :success
  end

  def test_show
    post :show, path: "#{LOGDIR}/foo.log"
    assert_response :success
  end

  def test_delete
    post :delete, path: "#{LOGDIR}/foo.log"
    assert_response :redirect
  end
end
