class TasksController < ApplicationController

  before_action :authenticate_user!, only:[:new, :edit, :update, :destroy]
  before_action :set_user_task, only:[:edit, :update]

  def show
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
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
  end

  def update
    if @task.update(task_params)
      redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(board), notice: '削除しました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content).merge(user_id: current_user.id)
  end

  def set_user_task
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end
end