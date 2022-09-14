# frozen_string_literal: true

# Test comment

class CodesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_code, only: %i[show edit update destroy]

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
      redirect_to @code, notice: 'Your code successfully created.'
    else
      render :new
    end
  end

  def update
    if @code.update(code_params)
      redirect_to @code
    else
      render :edit
    end
  end

  def destroy
    @code.destroy
    redirect_to codes_path
  end

  private

  def load_code
    @code = Code.find(params[:id])
  end

  def code_params
    params.require(:code).permit(:code)
  end
end
