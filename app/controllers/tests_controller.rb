class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_test, only: %i[show edit update destroy]

  def index
    @tests = Test.all
  end

  def show
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def create
    @test = Test.create(test_params)

    if @test.save
      redirect_to @test, notice: 'Your code successfully created.'
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  private

  def load_code
    @test = Test.find(params[:id])
  end

  def code_params
    params.require(:test).permit(:marker, :configuration_number, :configuration_text,
                                 :cartridge_type, :reagent, :production_date, :testing_date, :code,
                                 :conclusion, :description)
  end
end
