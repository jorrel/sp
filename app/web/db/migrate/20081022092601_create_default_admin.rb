class CreateDefaultAdmin < ActiveRecord::Migration
  def self.up
    Admin.create!(:login => 'admin',
                  :password => 'password',
                  :password_confirmation => 'password')
  end

  def self.down
    execute "DELETE FROM admins WHERE login = 'admin'"
  end
end
