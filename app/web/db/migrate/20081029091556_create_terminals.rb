class CreateTerminals < ActiveRecord::Migration
  def self.up
    create_table :terminals do |t|
      t.column 'college', :string, :limit => 10
      t.column 'name', :string, :limit => 30
      t.column 'description', :string
      t.column 'ip_address', :string, :limit => 15
      t.timestamps
    end
    add_index :terminals, :college
    add_index :terminals, :ip_address
  end

  def self.down
    drop_table :terminals
  end
end
