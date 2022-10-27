class CommentsController < ApplicationController
  before_action :find_test, only: %i[ new create ]
  before_action :set_comment, only: %i[ show edit update destroy ]

  def new
    @comment = @test.comments.new
  end

  def create
    @comment = @test.comments.create(comment_params)
    #@comment.user_id = current_user.id
  end

  def destroy
    @comment.destroy
    redirect_to @comment.test
  end
  
  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def set_comment
    @acomment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :user_id)
  end
end
