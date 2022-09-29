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
        for k in (2..5)
          b = 'test_device.' + Command.keys1(k) + j.to_s
          if k == 5
            eval(Command.f_equate(a, b, j, k))  # (a,b,j,k) in a = b
          else          
            if eval('(test_device.time_channel_' + j.to_s + '=~ /[a-zA-Z]/).nil?')
              t_time = 'test_device.' + Command.keys1(k) + j.to_s
              data_result[Command.keys1(0) + j.to_s] += 1 if !data_result[Command.keys1(0) + j.to_s].nil? && k == 2
              data_result = record_value(data_result, j, k, test_device)
            end
          end
        end
        data_result['devices'][test_device.device_id] = hash_test_device
      end
    end
    calc_average(data_result)
  end

  def self.calc_average(data_result)
    count = nil
    vol_average = nil
    for j in (1..4)
      eval("vol_average = data_result['average_channel_" +j.to_s + "']")
      eval("count = data_result['count_device_channel_" +j.to_s + "']")
      if !count.nil?
        puts('vol_average/count.to_f = ' + (vol_average/count.to_f).to_s)
        s1 = "vol_average = data_result['average_channel_" +j.to_s + "'] = "
        s2 = 'vol_average/count.to_f'
        eval(s1 + s2)
      end
    end
    data_result
  end

  def self.record_value(data_result, j, k, test_device)
    h_key = Command.keys1(k) + j.to_s
    b = eval('test_device.' + Command.keys1(5) + j.to_s )
    if data_result[h_key] == nil 
      data_result[Command.keys1(0) + j.to_s] = 1
      eval(Command.f_equate('data_result', b, j, k))  # (a,b,j,k) in a = b
    else 
      eval('data_result = calc_need_meaning(data_result, h_key, b, test_device)') 
    end
    data_result
  end

  def self.calc_need_meaning(data_result, h_key, b, test_device)
    
    if h_key.include? 'max'
      eval('data_result[h_key] = b.to_i if data_result[h_key] < b.to_i' )
    elsif h_key.include? 'min'
      eval('data_result[h_key] = b.to_i if data_result[h_key] < b.to_i' )  
    else
      eval('data_result[h_key] += b.to_i')
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
