class CalcGraph
    def self.graph(test)  # переделать запрос, добавить связи между таблицами
      com_data = ResultTest.find_by_sql(["SELECT * from result_tests where marker = ? order by device_id, created_at", test.marker])
  
      data_passage(com_data, test.code.threshold)
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
      puts(result_hash)
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
        hash_device['name'][j] = find_name_channel(j, rec)
        hash_device['graph'][j] = find_volume_graph(j, rec)
        hash_device['color'][j] = find_color(j)
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
      puts('0 hash_device =', hash_device)
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