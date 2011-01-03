module IRB
  class Context
    alias :original_evaluate :evaluate
    def evaluate(line, line_no)
      line = line.split(/\$(?=\s|\n)/).inject{|a, b| "(#{a}).#{b}"}
      original_evaluate(line, line_no)
    end
  end
end
