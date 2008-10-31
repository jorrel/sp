class CreateDefaultAdmin < ActiveRecord::Migration
  def self.up
    Admin.create!(:login => 'admin',
                  :password => 'password',
                  :password_confirmation => 'password',
                  :superadmin => true)
  end

  def self.down
    execute "DELETE FROM admins WHERE login = 'admin'"
  end
end
