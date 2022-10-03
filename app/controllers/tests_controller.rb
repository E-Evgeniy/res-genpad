class TestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_test, only: %i[show edit update destroy]

  def index
    @tests = Test.all
  end

  def show
    @result_test = CalcVolume.result(@test)
    @result_graph = CalcGraph.graph(@test)

    @graph1 = {"1" => 2, "2" => 3, "3" => 5, "4" => 6, "5" => 5, "6" => 4 }
  
    @graph2 = {"1" => 1, "2" => 5, "3" => 10, "4" => 15, "5" => 20, "6" => 4 }

     
    #  @result_graph ={
    #   '1245' => {
    #        'g1' => {
    #         'graph1' => {"1" => 2, "2" => 3, "3" => 5, "4" => 6, "5" => 5, "6" => 4 },
    #         'name' => "COVID",
    #         'color' => 'green'},
    #    'g2' => {
    #    'graph2' => {"1" => 1, "2" => 5, "3" => 10, "4" => 15, "5" => 20, "6" => 4 },
    #      'name' => "IPC",
    #      'color' => 'blue'}
    #      }, 
    #  '8621' => {
    #    'g1' => {
    #      'graph1' => {"1" => 10, "2" => 5, "3" => 1, "4" => 6, "5" => 5, "6" => 4 },
    #      'name' => "COVID",
    #      'color' => 'green'}, 
    #    'g2' => {
    #      'graph2' => {"1" => 1, "2" => 5, "3" => 10, "4" => 15, "5" => 20, "6" => 4 },
    #      'name' => "IPC",
    #      'color' => 'blue'}
    #      }
    #      }

    @result_graph ={'1245' => {
      'g1' => {
      'graph' => {"1" => 2, "2" => 3, "3" => 5, "4" => 6, "5" => 5, "6" => 4 },
       'name' => "COVID", 'color' => 'green' },
      'g2' => {
        'graph' => {"1" => 2, "2" => 3, "3" => 11, "4" => 12, "5" => 10, "6" => 40 }, 
         'name' => 'hjh',
         'color' => 'yellow'}}}

   
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