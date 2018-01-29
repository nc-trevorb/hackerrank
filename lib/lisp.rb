class Lisp
  class ParseError < StandardError; end

  class << self
    def evaluate(input)
      new(input).evaluate
    end
  end

  attr_reader :input

  def initialize(input)
    @input = input
  end

  def evaluate
    case input[0]
    when "'"
      symbols = get_symbols(input[1..-1])
      symbols.map{|s| Lisp.evaluate(s)}
    when '('
      nil
    else
      input.to_i
    end
  end

  def get_symbols(str)
    if !(str.start_with?('(') && str.end_with?(')'))
      raise ParseError
    else
      str[1..-2].split
    end
  end
end