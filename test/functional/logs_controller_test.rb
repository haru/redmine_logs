require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class LogsControllerTest < Redmine::ControllerTest
  fixtures :projects, :users, :roles, :members

  LOGDIR = File.expand_path("#{Rails.root}/log")

  def setup
    User.current = nil
    @request.session[:user_id] = 1 # admin user
    @test_log = File.join(LOGDIR, 'test_logs_plugin.log')
    File.open(@test_log, 'w') do |f|
      f.puts('Line 1: Hello from Logs test')
      f.puts('Line 2: Test log entry')
      f.puts('Line 3: Finished entry')
    end
  end

  def teardown
    File.delete(@test_log) if File.exist?(@test_log)
  end

  def test_index_as_admin
    get :index
    assert_response :success
    assert_select 'table.list'
  end

  def test_index_as_non_admin_denied
    @request.session[:user_id] = 2 # standard user
    get :index
    assert_response :forbidden
  end

  def test_index_as_anonymous_redirected_to_login
    @request.session[:user_id] = nil
    get :index
    assert_response :redirect
  end

  def test_show_log
    post :show, params: { path: @test_log }
    assert_response :success
    assert_includes @response.body, 'Line 1: Hello from Logs test'
  end

  def test_download_log
    get :download, params: { path: @test_log }
    assert_response :success
  end

  def test_delete_log
    post :delete, params: { path: @test_log }
    assert_response :redirect
    assert_redirected_to action: :index
    assert !File.exist?(@test_log)
  end

  def test_path_traversal_attack_blocked
    post :show, params: { path: '/etc/passwd' }
    assert_response :forbidden
  end

  def test_relative_path_traversal_blocked
    post :show, params: { path: "#{LOGDIR}/../../config/database.yml" }
    assert_response :forbidden
  end
end
