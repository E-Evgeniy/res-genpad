class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_test, only: %i[show edit update destroy]

  def index
    @tests = Test.all
  end

  def show
    @result_test = CalcVolume.result(@test)
    puts(@result_test)
    if @result_test['name_channel_1'] != 'ERROR' 
      result_graphs = CalcGraph.graph(@test)
      @device_graphs = CalcGraph.hash_formation_with_graphs(result_graphs)
      @common_graph = CalcGraph.common_graph(result_graphs)
    else
      @result_test = nil
    end
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def create_test(params)
    if !Check.files_exists(params[:marker])
      redirect_to new_test_path, alert: 'Тестов с маркером ' + params[:marker].to_s + ' не найдено'
      return
    end  

    @test = Test.create(params)
    @test.user_id = current_user.id
    ReadFile.new_report(@test)
   if @test.save
     redirect_to @test, notice: 'Your report successfully created.'
   else
     render :new
    end
  end

  def create
    result = Check.check_test_params(test_params)
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
                                 :cartridge_type, :reagent, :production_date, :testing_date,
                                 :conclusion, :description, :user_id, :header, :fluid)
  end
end