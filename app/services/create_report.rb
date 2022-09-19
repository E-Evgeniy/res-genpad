class CreateReport
  def new_report(test)
    folder = Address.last.address
    all_files = Dir.entries(folder)
    marker = test.marker
    find_results(all_files, marker, folder)
  end

  def find_results(all_files, marker, folder)
    all_files.each do |file|
      if file.include? marker
        adress = folder + file
        require 'csv'
        file_with_data = CSV.read(adress)
        export_data(file_with_data)
      end
    end
  end 

  def export_data(file_with_data, marker)
    hash_test_device = {}
    file.each_with_index do |row, index|
      next if index == 0
      if index <= 9
        hash_test_device = find_hash_test_device(hash_test_device, row, index)
      else
        create_result_test(marker, devise, channels)
      end
    end
  end

  def find_hash_test_device(hash_test_device, row, index)
    case index
    when 1
      hash_test_device[date_test] = find_date_test(row[0])
    when 2
      hash_test_device[device_id] = find_device_id(row[0])
    
    hash_test_device
  end

  def find_date_test(string_with_date)
    date_s = string_with_date[6..13].gsub('/','.')
    s0 = date_s[0]
    s1 = date_s[1]
    s3 = date_s[3]
    s4 = date_s[4]
    date_s[0] = s3
    date_s[1] = s4
    date_s[3] = s0
    date_s[4] = s1
    time_s = string_with_date[16..23]
    DateTime.parse(date_s + 'T' + time_s).to_time
  end

  def find_device_id(string_device_id)

  end
end