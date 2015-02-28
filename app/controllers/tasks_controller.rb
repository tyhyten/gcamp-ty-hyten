class TasksController < ApplicationController
  before_action :logged_in?
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
  end

  def edit
    @task = Task.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    @task.project_id = @project.id
      if @task.save
      redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @project = Project.find(params[:project_id])
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
      redirect_to project_tasks_path, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :complete, :date)
    end

    def current_user
      if session[:user_id]
        User.find(session[:user_id])
      end
    end

    def logged_in?
      if current_user.nil?
      redirect_to root_path
      end
    end

end
