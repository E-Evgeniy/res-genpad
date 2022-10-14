class CalcGraph
  def self.graph(test)  # переделать запрос, добавить связи между таблицами
    com_data = ResultTest.find_by_sql(["SELECT * from result_tests where marker = ? order by device_id, created_at", test.marker])
    data_passage(com_data, TestsDevice.find_by(marker: test.marker).threshold)
  end

  def self.hash_formation_with_graphs(result_hash)
    result_graph = {}
    result_hash.each do |key, device|  # record analyzed values     
      graph = ''
      for j in (1..4) 
        next if check_none(j, device)
        graph = rec_result_graph(graph, j, device)
      end

      if !graph.empty?
        graph = rec_result_graph(graph, 0, device)  #rec_threshold
        result_graph[key] = {}
        result_graph[key] = "line_chart [" + graph + "]"
      end 
    end
    result_graph
  end

  def self.rec_result_graph(graph, j, device)
    if graph.empty?
      graph = generate_str_res_h(j, device)
    else
      graph = graph + ", " + generate_str_res_h(j, device)
    end
    graph
  end

  def self.generate_str_res_h(j, device)
    name_g = eval("device['g" + j.to_s + "']['name']")
    data_g = eval("device['g" + j.to_s + "']['graph']")
    color_g = eval("device['g" + j.to_s + "']['color']")
    "{name: '" + name_g + "', data: " + (data_g).to_s + ", color: '" + color_g + "'}"
  end

  def self.common_graph(result_hash)
    graph = init_graph
    i = 1
    result_hash.each do |key, device|  # record analyzed values    
      for j in (1..4) 
        next if check_none(j, device)
        graph[j] = rec_graph(j, graph[j], key, device, i) if !eval("device['g" + j.to_s + "']['name']").nil?
      end
      i += 1
    end
   rec_threshold_and_form_result_graph(graph, result_hash.first[1])
  end

  def self.rec_threshold_and_form_result_graph(graph, device)
    for j in (1..4) 
      next if check_none(j, device)
      if !eval("device['g" + j.to_s + "']['name']").nil?
        graph[j] = rec_graph(0, graph[j], '', device, 0) 
        graph[j] = "line_chart [" + graph[j] + "]"
        graph[j + 4] = eval("device['g" + j.to_s + "']['name']").upcase
      end
    end
    graph
  end

  def self.rec_graph(j, graph, key, device, i)
    if graph.empty?
      graph = generate_str(j, key, device, i)
    else
      graph = graph + ", " + generate_str(j, key, device, i)
    end
    graph
  end

  def self.check_none(j, device)
    eval("'NONE' == device['g" + j.to_s + "']['name']" )
  end

  def self.generate_str(j, key, device, i)
    if j == 0
      name_g = 'threshold'
    else
      name_g = "Device ID " + key.to_s
    end
    data_g = eval("device['g" + j.to_s + "']['graph']")
    color_g = Command.generator_color(i)
    "{name: '" + name_g + "', data: " + (data_g).to_s + ", color: '" + color_g + "'}"
  end        

  def self.init_graph
    graph = {}
    for j in (1..4) 
      graph[j] = ''
    end
    graph
  end
  
    def self.data_passage(com_data, threshold)
      device_id = 0
      result_hash = {}
      hash_device = {}
      com_data.each do |rec| 
        if device_id == rec.device_id 
          hash_device = rec_volume_channels(hash_device, rec) if check_volume(rec)
        else
          result_hash[device_id] = hash_device if !hash_device.empty?
          hash_device = init_begin_data_device(rec, threshold) if check_volume(rec)
          device_id = rec.device_id
        end                
      end 
      result_hash[device_id] = hash_device if result_hash[device_id].nil?
      result_hash.each do |device_id, rec|
        result_hash[device_id] = generated_hash(rec)
      end
      result_hash
    end

    def self.generated_hash(rec)
      for j in (1..4)
        eval("rec['g" + j.to_s + "']['graph'] = normalization(rec['g" + j.to_s + "']['graph']" + ")")
        eval("rec['g" + j.to_s + "']['graph'] = change_graph(rec['g" + j.to_s + "']['graph']" + ")")
        eval("rec['g" + j.to_s + "']['graph'] = sec_in_min(rec['g" + j.to_s + "']['graph']" + ")")
      end
      rec
    end

    def self.sec_in_min(g_sec)
      g_min = {}
      for j in (1..g_sec.size)
        if j%2 == 0
          g_min[(j/2).to_s] = g_sec[j.to_s]
        end
      end  
      g_min    
    end

    def self.normalization(g)
      min_value = g.values.min.to_i
      g.each do |index, vol|
        g[index] = vol.to_i - min_value
      end
      g
    end

    def self.change_graph(g)
      g['1'] = 0
      for j in (2..g.size - 6)
        i = (j-1).to_s
        a = j.to_s
        b = (j+1).to_s
        c = (j+2).to_s
        d = (j+3).to_s
        f = (j+4).to_s
        e = (j+5).to_s
        if g[b] > g[a] && g[c] > g[a] && g[d] > g[a] && g[f] > g[a] && g[e] > g[a]
            g[a] = g[b]
        else
          g[a] = g[i]
        end
        g[a] = g[i] if g[a] < g[i]
      end
      for j in (g.size - 5..g.size)
        a = j.to_s
        b = (j-1).to_s
        g[a] = g[b] if g[a] < g[b]
      end
      g
    end

    def self.rec_volume_channels(hash_device, rec)
      n = 0
      for j in (1..4)
        eval("n = (hash_device['g" + j.to_s + "']['graph'].size + 1).to_s")
        eval("hash_device['g" + j.to_s + "']['graph'][n] = find_volume_graph(j, rec)")
      end
      hash_device
    end

    def self.check_volume(rec)
      if rec.volume_channel_1.nil? && rec.volume_channel_2.nil? && rec.volume_channel_3.nil?  && rec.volume_channel_4.nil?
        false
      else
        true
      end
    end
  
    def self.record_begin_data_device(hash_device, rec)
      for j in (1..4)
        name = find_name_channel(j, rec)
        puts('NAME = ',name)
        if name != "none"
          hash_device['name'][j] = name
          hash_device['graph'][j] = find_volume_graph(j, rec)
          hash_device['color'][j] = find_color(j)
        end        
      end
      hash_device
    end
  
    def self.find_volume_graph(j, rec)
      eval("rec['volume_channel_" + (j).to_s + "'].to_i")
    end
  
    def self.find_name_channel(j, rec)
      if j == 0
        'threshold'
      else  
        eval("rec['name_channel_" + (j).to_s + "'].upcase")
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
  
    def self.init_begin_data_device(rec, threshold)
      hash_device = {}
      for j in (0..4)
        eval("hash_device['g" + j.to_s + "'] = {}")
        for n in (0..2)          
          if j == 0 && n == 2
            hash_device['g0']['graph'] = {}
            hash_graph = rec_hash_graph(threshold)
            hash_device['g0']['graph'] = hash_graph
          else
            hash_device = rec_hash_device(hash_device, n, j, rec)            
          end
        end
      end  
      hash_device
    end 
    
    def self.rec_hash_graph(threshold)
      hash_graph = {}  
      for j in (1..40)
        hash_graph[j.to_s] = threshold
      end
      hash_graph
    end

    def self.rec_hash_device(hash_device, n, j, rec)
      eval("hash_device['g" + j.to_s + "']['" + commands_init_graph(n) + "'] = {}")
      if n != 2
        eval("hash_device['g" + j.to_s + "']['" + commands_init_graph(n) + "'] = func_rec(n, j, rec)")
      else
        eval("hash_device['g" + j.to_s + "']['" + commands_init_graph(n) + "']['1'] = func_rec(n, j, rec)")
      end
      
      hash_device
    end

    def self.func_rec(n, j, rec)
      if n == 0
        find_name_channel(j, rec)
      elsif n == 1
        find_color(j)
      else
        find_volume_graph(j, rec)
      end
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