class ReadFile
  def self.new_report(test)
    folder = Address.last.address
    all_files = Dir.entries(folder)
    marker = test.marker
    find_results(all_files, marker, folder)
  end

  def self.find_results(all_files, marker, folder)
    require 'csv'
    result_report = {}
    all_files.each do |file|
      if file.include? marker
        result_report = read_test_file(file, result_report, marker, folder)
      end
    end
    result_report
  end

  def self.read_test_file(file, result_report, marker, folder)
    file_with_data = File.open(folder + file, "r:ISO-8859-1")
    result_report = export_data(file_with_data, marker, result_report)
  end

  def self.export_data(file_with_data, marker, result_report)
    hash_test_device = {}
    hash_test_device['vol'] = {}
    hash_test_device['marker'] = marker
    file_with_data.each_with_index do |row, index|
      row = change_row(row)    
      hash_test_device = rec_hash_test_device(row, hash_test_device, index)
    end
    create_result(hash_test_device) if !hash_test_device.empty?
  end

  def self.create_result(hash)
    create_test_device(hash)
    if !hash['vol'].empty?
      hash['vol'].each do |index, rec|
        create_result_test(index, rec, hash)
      end
    end
  end

  def self.create_result_test(index, rec, hash)
    puts('eeee',rec)
    jv = 7
    rt = ResultTest.new
    for j in (1..4)
      if j == 4
        for i in (1..4)
          atr = Command.save_test_device(j)+ i.to_s
          atr_v = Command.save_test_device(jv) + i.to_s
          eval("rt." + atr + " = hash['" + atr + "']")
          eval("rt." + atr_v + " = rec['" + atr_v + "']" + '.to_i')
        end
      else
        atr = Command.save_test_device(j)
        puts("rt." + atr + " = hash['" + atr + "']")
        puts(eval("rec['" + atr + "']"))
        eval("rt." + atr + " = hash['" + atr + "']")  
      end
    end
    rt.unit_of_time = index
    puts('================================')
    puts(rt)
    rt.save
  end

  def self.create_test_device(hash)
    td = TestsDevice.new
    for j in (-2..6)
      if j.between?(4,6)
        for i in (1..4)
          atr = Command.save_test_device(j) + i.to_s
          eval("td." + atr + " = hash['" + atr + "']")
        end
      else
        atr = Command.save_test_device(j)
        eval("td." + atr + " = hash['" + atr + "']")
      end 
    end
    td.save
  end

  def self.rec_hash_test_device(row, hash_test_device, index)
    if row.include? 'STATUS:'
      hash_test_device['status'] = find_status(row)
    elsif row.include? 'DATE:'
      hash_test_device['date_test'] = find_date_test(row)
    elsif row.include? 'Device ID:'
      hash_test_device['device_id'] = meaning_from_s(row, 'Device ID:')
    elsif row.include? 'SAMPLE BARCODE:'
      hash_test_device['sample_barcode'] = meaning_from_s(row, 'SAMPLE BARCODE:')
    elsif row.include? 'Threshold:'
        hash_test_device['threshold'] = meaning_from_s(row, 'Threshold:')
    elsif index.between?(5,8)
      hash_test_device = rec_res_channels(row, hash_test_device, index)
    elsif index > 8 && hash_test_device['status'] != 'ERROR'
      hash_test_device['data'] = {} if hash_test_device['data'].nil?
      hash_test_device = rec_vol_channels(row, hash_test_device, index) if !row.nil? && !row.empty?
    end
    hash_test_device
  end

  def self.rec_vol_channels(row, hash, index)
    row = row.split
    count = hash['vol'].size
    hash['vol'][count] = {}
    i = 7
    for j in (1..4)
      name = Command.save_test_device(i) + j.to_s
      s1 = "hash['vol'][count]"
      s2 = "['" + name + "'] = " 
      s = (j-1).to_s
      s3 = "row[" + s +"]"
      eval(s1 + s2 + s3)
    end
    hash
  end

  def self.rec_res_channels(row, hash_test_device, index)
    if check_rec_error(hash_test_device, 'result_channel_4')
      hash_test_device = rec_error(hash_test_device)
    else
      j = index - 4     # 4 потому что на 5 строчке запись о 1 канале
      row_array = row.split
      hash_test_device = info_about_chanel(hash_test_device, row_array, j)
    end
    hash_test_device
  end

  def self.info_about_chanel(hash, row_array, j)
    i = 4
    name = Command.save_test_device(i) + j.to_s
    eval("hash['" + name +"'] = row_array[0]")

    time = Command.save_test_device(i+1) + j.to_s
    eval("hash['" + time +"'] = row_array[2]")

    result = Command.save_test_device(i+2) + j.to_s
    if row_array.include? 'N\A.'
      eval("hash['" + result +"'] = 'N\A'")
    else
      eval("hash['" + result +"'] = row_array[4]")    
    end
    
    hash
  end

  def self.rec_error(hash_test_device)
    for i in (1..4)  
      for j in (4..6)
        s1 = "hash_test_device['" + Command.save_test_device(j) 
        s2 = i.to_s + "'] = " 
        eval(s1 + s2 + "'ERROR'")
      end
    end
    hash_test_device
  end

  def self.check_rec_error(hash, name)
    return true if hash['status'] == 'ERROR' && hash[name].nil?
    false
  end

  def self.meaning_from_s(s_original, s_del)
    s_original.delete_prefix!(s_del).strip
  end

  def self.find_status(row)
    if row.include? 'STATUS: FINISHED'
      'FINISHED'
    elsif row.include? 'STATUS: ERROR'
      'ERROR'
    end
  end

  def self.find_date_test(string_with_date)
    string_with_date = string_with_date.gsub('/','.').split
    date_s = string_with_date[1]
    s0 = date_s[0]
    s1 = date_s[1]
    s3 = date_s[3]
    s4 = date_s[4]
    date_s[0] = s3
    date_s[1] = s4
    date_s[3] = s0
    date_s[4] = s1
    time_s = string_with_date[2]
    DateTime.parse(date_s + 'T' + time_s).to_time
  end

  def self.change_row(row)
    row = row.chomp
    res = ''
    for j in (0..row.length)
      res += row[j] if row[j] != "\u0000" && row[j] != nil
    end
    res
  end

end