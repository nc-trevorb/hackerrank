class ParseError < StandardError; end

def evaluate(input)
  case input[0]
  when "'"
    symbols = get_symbols(input[1..-1])
    symbols.map{|s| evaluate(s)}
  when '('
    symbols = get_symbols(input)
    apply(symbols)
  when /\d/
    if input =~ /^\d*$/
      input.to_i
    else
      raise ParseError.new("can't parse #{input}")
    end
  else
    raise ParseError.new("can't start with #{input[0]}")
  end
end

def apply(symbols)
  return if symbols.empty?

  applied = symbols.dup

  symbols.each_with_index do |s, i|
    if s.is_a?(Array)
      applied[i] = apply(s).to_s
    end
  end

  case applied.first
  when '+', '-', '*', '/'
    applied[1..-1].map{|x| evaluate(x)}.inject(applied.first)
  else
    raise ParseError.new('invalid symbol')
  end
end

def get_symbols(input_sexpr)
  sexpr = input_sexpr.strip

  if !(sexpr.start_with?('(') && sexpr.end_with?(')'))
    raise ParseError.new('unbalanced parens')
  else
    str = sexpr[1..-2]
    first_paren = str.index('(')

    if first_paren
      last_paren = str.rindex(')')
      sub_expression = str[first_paren..last_paren]

      str[0..(first_paren-1)].split + [get_symbols(sub_expression)] + str[(last_paren+1)..-1].split
    else
      str.split
    end
  end
end
