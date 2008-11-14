#
# Improvements (a.k.a. "Enrichments") to Ruby's core objects
#
# @author: Jorrel Ang
# @version: 8.11.04
module CoreEnrichments


  #
  # <boolean>.humanize
  #
  # true.humanize  # => "Yes"
  # false.humanize # => "No"
  #
  module BooleanHumanization
    Chart = { true => 'Yes', false => 'No' }
    def humanize
      BooleanHumanization::Chart[self]
    end
  end
  ::TrueClass.send(:include, BooleanHumanization)
  ::FalseClass.send(:include, BooleanHumanization)


  #
  # Symbol#humanize
  #
  # :hello.humanize # => 'Hello'
  #
  module SymbolHumanization
    def humanize
      to_s.humanize
    end
  end
  ::Symbol.send(:include, SymbolHumanization)


  #
  # <integer>.maximum_tries(&block)
  #
  # 3.maximum_tries { some_method_that_may_return_false_or_nil_if_unsuccessful }
  # 5.maximum_tries { |i| the_array[i] }  # effectively coalesces the_array
  #
  # raise a MaximumTriesError if maximum_tries is received
  #
  class MaximumTriesError < StandardError; end
  module MaximumTries
    def maximum_tries
      tries, max_tries, result = 0, self, nil
      raise ArgumentError, "cannot try #{max_tries} times" if max_tries < 1
      begin
        result = yield tries
      end while !(result) and (tries += 1) < max_tries

      result or raise MaximumTriesError, "tried #{max_tries} but no successful result"
    end
  end
  ::Fixnum.__send__(:include, MaximumTries)
  ::Bignum.__send__(:include, MaximumTries)

end
