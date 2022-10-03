class CalcGraph
    def self.graph(test)  # переделать запрос, добавить связи между таблицами
      com_data = ResultTest.find_by_sql(["SELECT * from result_tests where marker = ? order by device_id, created_at", test.marker])
  
      data_passage(com_data, test.code.threshold)
    end
  
    def self.data_passage(com_data, threshold)
      device_id = ""
      result_hash = {}
      hash_device = {}
      com_data.each do |rec| 
        if device_id[device_id] == hash_device 
          hash_device = init_begin_data_device
          device_id = rec.device_id
          hash_device = record_begin_data_device(hash_device, rec)
        else
          hash_device[device_id] = hash_device if !hash_device.empty?
          hash_device = init_begin_data_device(rec, threshold)
          device_id = rec.device_id
        end
        puts('hash_device')
        puts(hash_device)
      end 
    end
  
    def self.record_begin_data_device(hash_device, rec)
      for j in (1..4)
        hash_device['name'][j] = find_name_channel(j, rec)
        hash_device['graph'][j] = find_volume_graph(j, rec)
        hash_device['color'][j] = find_color(j)
      end
      hash_device
    end
  
    def self.find_volume_graph(j, rec)
      eval("rec['volume_channel_" + (j+1).to_s + "'].to_i")
    end
  
    def self.find_name_channel(j, rec)
      if j == 0
        ''
      else  
        eval("rec['name_channel_" + (j+1).to_s + "']")
      end  
    end  
  
    def self.find_color(j)
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
      end
    end  
  
    def self.init_begin_data(name, graph, color)
      hash_device = {}
      hash_device['name'] = name
      hash_device['graph'] = graph
      hash_device['color'] = color
      hash_device
    end
  
    def self.init_begin_data_device(rec, threshold)
      hash_device = {}
  
      hash_device['g0'] = {}
      hash_device['g0']['name'] = ''
      hash_device['g0']['graph'] = {'0' => threshold, '90' => threshold}
      hash_device['g0']['color'] = 'black'
   
      for j in (0..4)
        eval("hash_device['g" + j.to_s + "'] = {}")
        for n (0..1)
          eval("hash_device['g" + j.to_s + "']['" + commands_init_graph(n) + "'] = {}")
          eval("hash_device['g" + j.to_s + "']['" + commands_init_graph(n) + "'] = find_name_channel(j, rec)")
        end
        eval("hash_device['g" + j.to_s + "']['name'] = {}")
        eval("hash_device['g" + j.to_s + "']['name'] = find_name_channel(j, rec)")
        eval("hash_device['g" + j.to_s + "']['color'] = find_color(j)")
        eval("hash_device['g" + j.to_s + "']['graph'][] = find_volume(j)")
      end  
  
  
      name = []
      graph = []
      color = []
      for j in (0..3)
        name[j] = {}
        graph[j] = []
        color[j] = {}
      end
      init_begin_data(name, graph, color)
    end 

    def self.commands_init_graph(n)
      case n
      when 0
        'name'  
      when 1
        'color'
      when 2
        'graph'
      end
    end 
  end