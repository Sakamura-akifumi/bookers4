class BookCommentsController < ApplicationController

  before_action :authenticate_user!
  # before_action :currect_user, only: [:destroy]
  # ログインしてるuserしか消せない

  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.user_id = current_user.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @book = Book.find(params[:book_id])
    comment = @book.book_comments.find(params[:id])
    comment.destroy
    redirect_to request.referrer
    else
     book_comment_user != current_user
     redirect_to book_path
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
