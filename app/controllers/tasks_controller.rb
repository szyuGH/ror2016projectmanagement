class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy, :claim, :unclaim]
  before_action :authenticate_user!
  before_filter :check_access_rights


  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @project.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.project = @project
    @task.bugs = params[:task][:bugs_attributes].values.map{|b| Bug.find_by_id(b[:id])} if params[:task][:bugs_attributes] != nil

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if task_params[:progress].to_i == 100
      @task.state = 2
      @task.finished_at = DateTime.now
    end
    respond_to do |format|
      if @task.update(task_params)
        # check if assigned bug is now finished
        @task.bugs.each do |bug|
          if !bug.tasks.any?{|t| Task.states[t.state] != 2}
            bug.state = 1
            bug.save
          end
        end
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        # p @task.errors.inspect
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def claim
    @task.developer = current_user
    @task.state = 1
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully claimed.' }
        format.json { render :index, status: :ok, location: @task }
      else
        format.html { redirect_to project_tasks_path(@project), notice: 'Task could not be claimed.' }
        format.json { render json: @task.errors, status: :unclaimable_entity }
      end
    end
  end

  def unclaim
    @task.developer = nil
    @task.state = 0
    @task.progress = 0
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully unclaimed.' }
        format.json { render :index, status: :ok, location: @task }
      else
        format.html { redirect_to project_tasks_path(@project), notice: 'Task could not be unclaimed.' }
        format.json { render json: @task.errors, status: :unclaimable_entity }
      end
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :progress, :deadline)
    end

    def check_access_rights
      if current_user.project_hierarchy?(@project) < 0
        go_back
      end
    end
end
