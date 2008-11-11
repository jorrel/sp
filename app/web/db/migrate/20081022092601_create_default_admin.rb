class CreateDefaultAdmin < ActiveRecord::Migration
  def self.up
    admin = Admin.new(:login => 'admin',
                      :password => 'password',
                      :password_confirmation => 'password')
    admin.superadmin = true # protected attribute
    admin.save!
  end

  def self.down
    execute "DELETE FROM admins WHERE login = 'admin'"
  end
end
