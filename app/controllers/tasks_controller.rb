class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
  end
  
  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_path(board), notice: '保存に成功しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :edit
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content).merge(user_id: current_user.id)
  end
end