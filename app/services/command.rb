class Command
  def self.give_c(s1, s2)
    s_out1 = ''
    s_out2 = ''

    case s1
    when 'r_new_test'
      s_out1 = 'redirect_to new_test_path'
    end

    case s2
    when 'no code'
      s_out2 = ", alert: 'The entered code does not exist'"
    when 'marker exists'
      s_out2 = ", alert: 'The entered marker already exists'"
    when 'no marker'
      s_out2 = ", alert: 'The marker must exist'"
    end

    s_out1 + s_out2
  end

  def self.ec_res_device(j)
    "data_result['devices'][test_device.id]['time_channel_" + j.to_s + "]" + 
       " = test_device.time_channel_" + j.to_s
  end

  def self.f_equate(a, b, j, k)
    a + "['" + keys1(k) + j.to_s + "'] = " + b
  end

  def self.keys1(k)
    case k
    when 0
      'count_device_channel_'  
    when 1
      'name_channel_'
    when 2
      'average_channel_'
    when 3
      'max_channel_'
    when 4
      'min_channel_'
    when 5
      'time_channel_'
    end
  end

  def self.generator_color(j)
    case j
    when 0
      'black'  
    when 1
      'red'
    when 2
      'yellow'
    when 3
      'blue'
    when 4
      'green'
    when 5
      'orange'  
    when 6
      'indigo'
    when 7
      'violet'
    when 8
      'brown'
    when 9
      'pink'
    when 10
      'grey'  
    when 11
      'olive'
    when 12
      'mint'
    when 13
      'lime'
    when 14
      'azure'
    when 15
      'lavender'  
    when 16
      'platinum'
    when 17
      'rust'
    when 18
      'silver'
    when 19
      'lilac'
    end
  end
end