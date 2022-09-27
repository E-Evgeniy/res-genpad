class ResultTest
  
  def self.result(test)
    data_result = {}
    test_devices = TestDevice.existence(test.marker)
    return if test_devices.nil?

    data_result['name_channel_1'] = test_devices[0].name_channel_1
    data_result['name_channel_2'] = test_devices[0].name_channel_2
    data_result['name_channel_3'] = test_devices[0].name_channel_3
    data_result['name_channel_4'] = test_devices[0].name_channel_4

    data_devices = {}
    sum_channel = []
    max_channel = []
    min_channel = []
    num_divice_channel = []

    test_devices.each do |test_device|
      hash_test_device = {}
      for j in (1..4)
        time_c = eval('test_device.time_channel_' + j.to_s)
        eval("hash_test_device['time_channel_" + j.to_s + "']" + ' = time_c')
        if time_c =~ /[a-zA-Z]/).nil?
          if num_divice_channel[j] == nil
            max_channel[j] = time_c
            min_channel[j] = time_c
            sum_channel[j] = time_c
            num_divice_channel[j] = 1
          else
            max_channel[j] = time_c if time_c > max_channel[j] 
            min_channel[j] = time_c if min_channel[j] < time_c
            sum_channel[j] = sum_channel[j] + time_c
            num_divice_channel[j] = num_divice_channel[j] + 1
          end
        end
      end
      data_devices[test_device.device_id] = hash_test_device
    end

    data_result['devices'] = data_devices
    for j in (1..4)
    end
    
  end

end