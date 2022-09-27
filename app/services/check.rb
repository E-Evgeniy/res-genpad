class Check
  def self.check_test_params(test_params)
    result = {}
    code = Code.existence(test_params['code_id'])

    if test_params['marker'].empty?
      result['alert'] = Command.give_c('r_new_test', 'no marker')
      return result
    end
   
    if code.exists?
      test_params['code_id'] = code.first.id
      result = further_check_test_perams(test_params)     
    else
      result['alert'] = Command.give_c('r_new_test', 'no code')
    end
    result
  end

  def self.further_check_test_perams(test_params) 
    result = {} 
    check_marker = Test.existence(test_params['marker'])
    if check_marker.first.nil?
      result['test_params'] = test_params
    else
      result['alert'] = Command.give_c('r_new_test', 'marker exists')  
    end 
    result
  end
end