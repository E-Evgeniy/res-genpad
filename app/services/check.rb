class Check
  def self.check_test_params(test_params)
    result = {}

    if test_params['marker'].empty?
      result['alert'] = Command.give_c('r_new_test', 'no marker')
      return result
    end

    further_check_test_perams(test_params)
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

  def self.files_exists(marker)
    folder = Address.last.address
    all_files = Dir.entries(folder)
    result = false
    all_files.each do |file|
      result = true if file.include? marker
    end
    result
  end
end