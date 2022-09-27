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
end