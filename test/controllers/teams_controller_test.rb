require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include Warden::Test::Helpers

  setup do
    @project = projects(:one)
    @team = teams(:one)
    @member = team_members(:one)
    @team.members << @member
    @project.team = @team
    sign_in users(:one)
  end

  test "should create teammember" do
    assert_difference('@team.members.count', 1) do
      put :create, project_id: @project.id, member_id: @team.members.first.id,
      team_member: { user_id: @member.user_id, is_admin: @member.is_admin }
    end

    assert_redirected_to project_team_path(@project)
  end

  test "should show team" do
    get :show, project_id: @project.id, id: @team
    assert_response :success
  end

  test "should add member" do
    get :add_member, project_id: @project.id
    assert_response :success
  end

  test "should remove member" do
    assert_difference('@team.members.count', -1) do
      get :remove_member, project_id: @project.id, member_id: @team.members.first.id
    end

    assert_redirected_to project_team_path(@project)
  end

  test "should promote member" do
    get :promote_member, project_id: @project.id, member_id: @member.id
    assert_equal(true, @team.members.first.is_admin)
    assert_redirected_to project_team_path(@project)
  end

  test "should demote member" do
    get :demote_member, project_id: @project.id, member_id: @member.id
    assert_equal(false, @team.members.first.is_admin)
    assert_redirected_to project_team_path(@project)
  end
end
