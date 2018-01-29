class Lisp
  class ParseError < StandardError; end

  class << self
    def eval(input)
      new(input).eval
    end
  end

  attr_reader :input

  def initialize(input)
    @input = input
  end

  def eval
    case input[0]
    when "'"
      []
    when '('
      nil
    else
      input.to_i
    end
  end
end