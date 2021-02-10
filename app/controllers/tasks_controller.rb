class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    else
      redirect_to '/login'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id 
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to '/'
    else
      flash.now[:denger] = 'Taskが投稿されませんでした'
      render :new
    end  
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to @task
    else
      flash.now[:denger] = 'Taskが更新されませんでした'
      render :new
    end  
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは削除されました'
    redirect_to tasks_url
  end


  private
  
  def set_task
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end

  def task_params
   params.require(:task).permit(:content, :status, :references)
  end  
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
    redirect_to '/'
    end
  end
end