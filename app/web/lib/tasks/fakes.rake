require 'spinner'
require 'faked_models'

namespace :fakes do
  def generating(what, &block)
    print "generating fake #{what} ... "
    spin(&block)
    print "done\n"
  end

  task :personnels do
    generating('personnels') {
      500.times { Personnel.fake! }
    }
  end

  task :admins => :personnels do
    generating('admins') {
      70.times { Admin.fake! }
    }
  end

  task :admin do
    admin = Admin.find_by_login('admin') || Admin.new
    admin.attributes = {:login => 'admin',
                        :password => 'password',
                        :password_confirmation => 'password'}
    admin.superadmin = true # protected attribute
    admin.save!
  end

  task :terminals do
    generating('terminals') {
      30.times { Terminal.fake! }
    }
  end

  task :students do
    generating('students') {
      1000.times { Student.fake! }
    }
  end

  task :all => [:admin, :admins, :terminals, :students] do
  end
end
