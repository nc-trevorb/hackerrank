require 'spec_helper'

describe Lisp do
  describe "#eval" do
    context "for valid inputs" do
      {
        # start with just integers
        "numbers" => ["1", 1],
        "null expression" => ["()", nil],
        "empty list" => ["'()", []],
        "list of numbers" => ["'(1 2 3)", [1, 2, 3]],

        # evaluate functions
        "addition" => ["(+ 6 2)", 8],
        "subtraction" => ["(- 6 2)", 4],
        "multiplication" => ["(* 6 2)", 12],
        "division" => ["(/ 6 2)", 3],

        # recursive evaluation
        "recursive evaluation" => ["(+ 6 (- 10 2))", 14],

        # add floats
        "floats" => ["1.5", 1.5],
        "float arithmetic" => ["(+ 1.5 (- 3.6 1.2))", 3.9],

        # add strings
        "strings" => ['"asdf"', "asdf"],
        "string functions" => ['(concat "as" "df")', "asdf"],

        # add bindings
        "bindings" => ["(let (x 1) (+ x 2))", 3],
      }.each do |desc, (expression, result)|
        it "should evaluate #{desc}: `#{expression} → #{result}`" do
          expect(Lisp.eval(expression)).to eq(result)
        end
      end
    end

    context "for invalid inputs" do
      {
        "missing close paren" => "(1",
        "missing open paren" => "1)",
        "invalid symbols" => "1asdf",
        "trying to apply non-function" => "(1 2 3)",
        "division by zero" => "(/ 1 0)",
        "type mismatch" => '(+ "asdf" 3)',
      }.each do |desc, expression|
        it "should raise an error for #{desc}" do
          expect { Lisp.eval(expression) }.to raise_error(Lisp::ParseError)
        end
      end
    end
  end
end