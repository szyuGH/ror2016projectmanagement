class UsersController < ApplicationController
  before_action :authenticate_user!

  def project_index
    @projects = current_user.assigned_projects
  end

  def task_index
    @tasks = current_user.tasks
  end

  def available_tasks
    @tasks = current_user.assigned_projects.map{|p| p.tasks.select{|t| t.developer.nil?}}.flatten
  end

end
