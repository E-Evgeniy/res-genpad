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
    @test.code_id = Code.find_by(code: test_params["code_id"]).id
    check_marker = Test.find_by(marker: @test.marker)
    @test.user_id = current_user.id
    if check_marker.nil?
      render :new, notice: 'The token marker be unique'
    else
     save_test(@test)
    end  
  end

  def save_test(test)
    if test.save
      CreateReport.new_report(test)
      redirect_to test, notice: 'Your code successfully created.'
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

  def load_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:marker, :configuration_number, :configuration_text,
                                 :cartridge_type, :reagent, :production_date, :testing_date, :code_id,
                                 :conclusion, :description, :user_id, :header, :fluid)
  end
end
