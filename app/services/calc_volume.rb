class CalcVolume
  def self.result(test)
    data_result = {}
    test_devices = TestsDevice.existence(test.marker)
    return if test_devices.nil?
    data_result = find_rec_start_fields(data_result,test_devices[0])
    data_result['devices'] = {}

    test_devices.each do |test_device|
      hash_test_device = {}
      a = 'hash_test_device'
      for j in (1..4)
        for k in (2..4)
          b = 'test_device.' + Command.keys1(k) + j.to_s
          if k > 0 && k < 4
            eval(Command.f_equate(a, b, j, k))  # (a,b,j,k) in a = b
          else
            if eval('(test_device.time_channel_' + j.to_s + '=~ /[a-zA-Z]/).nil?')
              t_time = 'test_device.' + Command.keys1(k) + j.to_s
              data_result = record_value(data_result, j, k, test_device)
            end
          end
        end
        data_result['devices'][test_device.device_id] = hash_test_device
      end
    end
    puts('data_result = ',data_result)
    data_result
  end

  def self.record_value(data_result, j, k, test_device)
    h_key = Command.keys1(5) + j.to_s
    b = 'test_device.' + Command.keys1(5) + j.to_s    
    if data_result[h_key] == nil 
      data_result[Command.keys1(0) + j.to_s] = 1
      puts('OOO ', Command.f_equate('data_result', b, j, k))
      eval(Command.f_equate('data_result', b, j, k))  # (a,b,j,k) in a = b
    else
      data_result[Command.keys1(0) + j.to_s] += 1 
      eval('data_result[h_key] = calc_need_meaning(data_result, h_key, b, test_device)') 
    end
    data_result
  end

  def self.calc_need_meaning(data_result, h_key, b, test_device)
    puts('1111 b = ',b)
    if h_key.include? 'max'
      eval('data_result[h_key] = b if data_result[h_key] < b' )
    elsif h_key.include? 'min'
      eval('data_result[h_key] = b if data_result[h_key] < b' )  
    else
      eval('data_result[h_key] += b')
    end
    data_result
  end


  def self.find_rec_start_fields(data_result, test_device)
    a = 'data_result'
    for j in (1..4)
      for k in (0..4)
        b = 'test_device.name_channel_' + j.to_s
        if k == 1
          eval(Command.f_equate(a, b, j, k))  # (a,b,j,k) in a = b   
        else
          eval(Command.f_equate(a, 'nil', j, k))  # (a,b,j,k) in a = b
        end        
      end
    end
    data_result
  end

end
