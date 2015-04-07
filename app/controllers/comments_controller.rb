class CommentsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
    @comment = Comment.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
    @comment = Comment.new(comment_params)
    @comment.task_id = @task.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end


    private

    def comment_params
      params.require(:comment).permit(:task_id, :user_id, :message)
    end

end
