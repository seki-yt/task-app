class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path, notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: '削除しました'
  end


  private
  def board_params
    params.require(:board).permit(:title, :content)
  end
end