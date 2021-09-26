class BookCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.save
    @book_comment = BookComment.new
  end


  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.find_by(book_id: @book.id)
    @book_comment.destroy
    @book_comment = BookComment.new
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end