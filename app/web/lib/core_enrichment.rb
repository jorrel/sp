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
TrueClass.send(:include, BooleanHumanization)
FalseClass.send(:include, BooleanHumanization)
