require 'spec_helper'

describe Lisp do
  describe "#evaluate" do
    context "for valid inputs" do
      ERROR = 'error!'

      {
        # start with just integers
        "should evaluate numbers" => ["1", 1],
        "should evaluate empty list" => ["'()", []],
        "should evaluate list of numbers" => ["'(1 2 3)", [1, 2, 3]],
        "should raise an error for lists missing closing parens" => ["'(1 2", ERROR],

        "should evaluate null expression" => ["()", nil],
        "should raise an error for missing close-parens" => ["(", ERROR],
        "should raise an error for missing open-parens" => [")", ERROR],
        "should raise an error for unbalanced s-expressions" => ["(+ 1", ERROR],

        # evaluate functions
        "should evaluate addition" => ["(+ 6 2)", 8],
        "should evaluate subtraction" => ["(- 6 2)", 4],
        "should evaluate multiplication" => ["(* 6 2)", 12],
        "should evaluate division" => ["(/ 6 2)", 3],
        "should raise an error for bogus functions" => ["(bogus 1 2 3)", ERROR],
        "should raise an error for division by zero" => ["(/ 1 0)", ERROR],

        # stricter parsing
        "should raise an error for invalid symbols" => ["1asdf", ERROR],
        "should raise an error for trying to apply non-function" => ["(1 2 3)", ERROR],

        # # recursive evaluation
        # "recursive evaluation" => ["(+ 6 (- 10 2))", 14],

        # # add floats
        # "floats" => ["1.5", 1.5],
        # "float arithmetic" => ["(+ 1.5 (- 3.6 1.2))", 3.9],

        # # add strings
        # "strings" => ['"asdf"', "asdf"],
        # "string functions" => ['(concat "as" "df")', "asdf"],
        # "should raise an error for type mismatch" => ['(+ "asdf" 3)', ERROR],

        # # add bindings
        # "bindings" => ["(let (x 1) (+ x 2))", 3],
      }.each do |desc, (expression, result)|
        it "#{desc}: `#{expression} → #{result}`" do
          if result == ERROR
            expect { Lisp.evaluate(expression) }.to raise_error(StandardError)
          else
            expect(Lisp.evaluate(expression)).to eq(result)
          end
        end
      end
    end
  end
end