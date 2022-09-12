class CodesController < ApplicationController 
  before_action :load_code, only: [:show, :edit, :update ]

  def index
    @codes = Code.all
  end

  def show
    
  end

  def new
    @code = Code.new
  end

  def edit    
  end

  def create
    @code = Code.create(code_params)

    if @code.save
      redirect_to @code
    else
      render :new
    end    
  end

  def update
    @code.update(code_params)
    redirect_to @code
  end

  private

  def load_code
    @code = Code.find(params[:id])
  end

  def code_params
    params.require(:code).permit(:code)
  end
end