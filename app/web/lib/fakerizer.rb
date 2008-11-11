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

  def new_fake
    new fake_attrs
  end

  def fake
    20.maximum_tries { (r = new_fake).valid? and r }
  end
  alias :valid_fake :fake

  def fake!
    returning(fake) { |f| f.save! }
  end
  alias :valid_fake! :fake!
end
class ActiveRecord::Base
  extend Fakerizer
end
