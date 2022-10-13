class CreateReport
  
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
        result_report['files exist'] = true     
        file_with_data = File.open(folder + file, "r:ISO-8859-1")
        export_data(file_with_data, marker)
      end
    end
    result_report
  end 

  def self.delete_chr(row)
    row = row.delete 0.chr
    row = row.delete 10.chr
    row = row.delete 13.chr
    row.split(' ') 
  end

  def self.export_data(file_with_data, marker)
    hash_test_device = {}
    file_with_data.each_with_index do |row, index|
      next if index == 0
      Uevice(hash_test_device, marker) if index == 9
      else
        create_result_test(marker, hash_test_device, row)
      end
    end
  end

  def self.find_hash_test_device(hash_test_device, row, index)
    case index
    when 1
      hash_test_device['date_test'] = find_date_test(row)
    when 2
      hash_test_device['device_id'] = row[2]
    when 3
      hash_test_device['sample_barcode'] = find_sample_barcode(row)
    when 4
      hash_test_device[row[0].downcase] = row[1]
    when 5..8
      h_key = 'name_channel_' + (index-4).to_s
      hash_test_device[h_key] = row[0].downcase

      h_key = 'time_channel_' + (index-4).to_s
      h_volume = row[2].match(/\d{2}[\s\d-]+/)
      
      if (row[2] =~ /[0-9]/).nil?
        h_volume = "N/A"
        res_test_chanel = row[3]
      else
        h_volume = row[2]
        res_test_chanel = row[4]
      end

      s = "hash_test_device['" + h_key + "'] = " + "'" + h_volume + "'"
      eval(s)

      h_key = 'result_channel_' +  + (index-4).to_s
      s = "hash_test_device['" + h_key + "'] = " + "'" + res_test_chanel + "'"
      eval(s)
    when 9
      hash_test_device['status'] = row[1]
    end
    hash_test_device
  end

  def self.create_result_test(marker, hash_test_device, row)
    rt = ResultTest.new
    rt.marker = marker
    rt.device_id = hash_test_device['device_id']
    rt.date_test = hash_test_device['date_test']
    rt.name_channel_1 = hash_test_device['name_channel_1']
    rt.volume_channel_1 = row[0]
    rt.name_channel_2 = hash_test_device['name_channel_2']
    rt.volume_channel_2 = row[1]
    rt.name_channel_3 = hash_test_device['name_channel_3']
    rt.volume_channel_3 = row[2]
    rt.name_channel_4 = hash_test_device['name_channel_4']
    rt.volume_channel_4 = row[3]
    rt.save
  end

  def self.create_test_device(hash_test_device, marker)
    td = TestsDevice.new
    td.date_test = hash_test_device['date_test']
    td.device_id = hash_test_device['device_id']
    td.sample_barcode = hash_test_device['sample_barcode']
    td.threshold = hash_test_device['threshold']
    td.marker = marker
    td.name_channel_1 = hash_test_device['name_channel_1']
    td.name_channel_2 = hash_test_device['name_channel_2']
    td.name_channel_3 = hash_test_device['name_channel_3']
    td.name_channel_4 = hash_test_device['name_channel_4']
    td.time_channel_1 = hash_test_device['time_channel_1']
    td.time_channel_2 = hash_test_device['time_channel_2']
    td.time_channel_3 = hash_test_device['time_channel_3']
    td.time_channel_4 = hash_test_device['time_channel_4']
    td.result_channel_1 = hash_test_device['result_channel_1']
    td.result_channel_2 = hash_test_device['result_channel_2']
    td.result_channel_3 = hash_test_device['result_channel_3']
    td.result_channel_4 = hash_test_device['result_channel_4']
    td.status = hash_test_device['status']
    td.save
  end

  def self.find_sample_barcode(row)
    sample_barcode = ""
    if row.length > 1
        (2..row.length - 1).each do |i|
          sample_barcode = sample_barcode + row[i]
        end
    else
      sample_barcode = "None"
    end
    sample_barcode
  end

  

  def self.find_date_test(string_with_date)
    date_s = string_with_date[1].gsub('/','.')
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

end