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
  end
end