require 'test_helper'

class BugsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include Warden::Test::Helpers

  setup do
    @project = projects(:one)
    @bug = bugs(:first_bug)
    sign_in users(:one)
  end

  test "should get index" do
    get :index, project_id: @project.id
    assert_response :success
    assert_not_nil assigns(:bugs)
  end

  test "should get new" do
    get :new, project_id: @project.id
    assert_response :success
  end

  test "should create bug" do
    assert_difference('Bug.count') do
      post :create, project_id: @project.id, bug: { title: @bug.title, description: @bug.description,
        severity: @bug.severity, state: @bug.state, screenshot: @bug.screenshot }
    end

    assert_redirected_to project_bug_path(@project, assigns(:bug))
  end

  test "should show bug" do
    get :show, project_id: @project.id, id: @bug
    assert_response :success
  end

  test "should get edit" do
    get :edit, project_id: @project.id, id: @bug
    assert_response :success
  end

  test "should update bug" do
    patch :update, id: @bug, project_id: @project.id, bug: { title: @bug.title, description: @bug.description,
      severity: @bug.severity, state: @bug.state, screenshot: @bug.screenshot }
    assert_redirected_to project_bug_path(@project, assigns(:bug))
  end

  test "should destroy bug" do
    assert_difference('Bug.count', -1) do
      delete :destroy, project_id: @project.id, id: @bug
    end

    assert_redirected_to project_bugs_path(@project)
  end
end
