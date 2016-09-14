require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include Warden::Test::Helpers

  setup do
    @project = projects(:one)
    @task = tasks(:first_task)
    @task.project = @project
    sign_in users(:one)
  end

  test "should get index" do
    get :index, project_id: @project.id
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get new" do
    get :new, project_id: @project.id
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, project_id: @project.id, task: { title: @task.title, description: @task.description,
        progress: @task.progress, state: @task.state, deadline: @task.deadline }
    end

    assert_redirected_to project_task_path(@project, assigns(:task))
  end

  test "should show task" do
    get :show, project_id: @project.id, id: @task
    assert_response :success
  end

  test "should get edit" do
    get :edit, project_id: @project.id, id: @task
    assert_response :success
  end

  test "should update task" do
    patch :update, id: @task.id, project_id: @project.id, task: { title:@task.title, description:@task.description, progress: @task.progress, deadline: @task.deadline }
    assert_redirected_to project_task_path(@project, assigns(:task))
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, project_id: @project.id, id: @task
    end

    assert_redirected_to project_tasks_path(@project)
  end

  test "should claim task" do
    get :claim, id: @task, project_id: @project.id
    assert_not_nil assigns(@task.developer)
  end

  test "should unclaim task" do
    get :unclaim, id: @task, project_id: @project.id
    assert_nil(@task.developer)
  end
end
