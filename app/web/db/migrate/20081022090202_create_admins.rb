class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table "admins", :force => true do |t|
      t.column :login,                     :string, :limit => 40
#       t.column :name,                      :string, :limit => 100, :default => '', :null => true
#       t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :superadmin,                :boolean, :default => false
      t.column :personnel_id,              :integer

    end
    add_index :admins, :login, :unique => true
    add_index :admins, :updated_at
    add_index :admins, :personnel_id
    add_index :admins, :superadmin
  end

  def self.down
    drop_table "admins"
  end
end
