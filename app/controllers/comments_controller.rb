class CommentsController < ApplicationController
  before_action :find_test, only: %i[ new create ]
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]

  def new
    @comment = @test.comments.new
  end

  def create
    puts('current_user', current_user)
    
    puts('comment_params',comment_params_for_create(comment_params))
    @comment = @test.comments.create(comment_params_for_create(comment_params))
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

  def comment_params_for_create(params)
    params['user_id'] = current_user.id
    params
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
