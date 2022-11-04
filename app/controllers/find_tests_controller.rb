class FindTestsController < ApplicationController
  before_action :authenticate_user!
  def find
    @tests = Test.find_by_sql(["SELECT * from tests ORDER BY created_at DESC LIMIT 10"])
  end

  def result
    hash_data = find_hash_data(params[:data_begin], params[:data_end])
    return if hash_data.nil?
    @tests = Test.find_by_sql(["SELECT * from tests where testing_date between ? and ?",
         hash_data['data_begin'], hash_data['data_end']])
  end

  private

  def find_hash_data(data_begin, data_end)
    return if Test.all.empty?
    hash_data = {}
    if data_begin.empty?
      hash_data['data_begin'] = Test.order(testing_date: :asc).first.testing_date
    else
      hash_data['data_begin'] = data_begin.to_date
    end

    if data_end.empty?
      hash_data['data_end'] = Test.order(testing_date: :desc).first.testing_date
    else
      hash_data['data_end'] = data_end.to_date
    end

    hash_data
  end 

  def test_params
    params.require(:find_test).permit(:data_begin, :data_end)
  end
end