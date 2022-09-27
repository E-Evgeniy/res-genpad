class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_test, only: %i[show edit update destroy]

  def index
    @tests = Test.all
  end

  def show
    @result_test = ResultTest.result(@test)
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def create_test(params)
    @test = Test.create(params)
    @test.user_id = current_user.id
    if @test.save
      CreateReport.new_report(@test)
      redirect_to @test, notice: 'Your code successfully created.'
    else
      render :new
    end
  end

  def create
    result = Check.check_test_params(test_params)
    puts('result',result)
    if result['test_params'].nil?
      return eval(result['alert'])
    else
      create_test(result['test_params'])
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

  def load_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:marker, :configuration_number, :configuration_text,
                                 :cartridge_type, :reagent, :production_date, :testing_date, :code_id,
                                 :conclusion, :description, :user_id, :header, :fluid)
  end
end