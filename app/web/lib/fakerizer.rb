require 'faker'

#
# Create fake records
#
# class User
#   fake_attr :first_name => Faker::Name.first_name
# end
#
# User.fake!    # creates a fake user
#
module Fakerizer
  def fake_attr(&block)
    if block_given?
      @@fake_attrs ||= {}
      @@fake_attrs[self] = block
    else
      if block = @@fake_attrs[self] and block.respond_to?(:call)
        block.call
      else
        raise "No fake attrs set"
      end
    end
  end
  alias :fake_attrs :fake_attr

  def fake
    10.maximum_tries { (r = new fake_attrs).valid? and r }
  end

  def fake!
    f = fake
    f.save!
    f
  end
end
class ActiveRecord::Base
  extend Fakerizer
end
