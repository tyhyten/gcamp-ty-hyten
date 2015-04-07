class TasksController < ApplicationController
  before_action :logged_in?
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  def show
    @user = current_user
    @task = Task.find(params[:id])
    @project = Project.find(params[:project_id])

    @comment = Comment.new

    @comments = @task.comments.all
  end

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

  def update
    @project = Project.find(params[:project_id])
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
      redirect_to project_tasks_path, notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

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
