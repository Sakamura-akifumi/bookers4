class BookCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment = BookComment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = params[:book_id]
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

  def comment_params
    params.require(:book_comment).permit(:body)
  end

end