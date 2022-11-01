class CommentsController < ApplicationController
  before_action :find_test, only: %i[ new create ]
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]
  after_action :publish_comment, only: [:create]

  def new
    @comment = @test.comments.new
  end

  def create
    @comment = @test.comments.create(comment_params_for_create(comment_params))
  end

  def destroy
    @comment.destroy
    redirect_to @comment.test
  end
  
  private

  def publish_comment
    return if @comment.errors.any?

    data = ApplicationController.render partial: 'comments/comment', locals: { comment: @comment }
 
    ActionCable.server.broadcast 'comment_channel',
                                      content: data
  end

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
