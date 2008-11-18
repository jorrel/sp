class CreatePersonnels < ActiveRecord::Migration
  def self.up
    create_table :personnels do |t|
      t.column :personnel_id, :integer, :unique => true, :null => false
      t.column :first_name, :string, :limit => 30
      t.column :middle_name, :string, :limit => 30
      t.column :last_name, :string, :limit => 30
      t.timestamps
    end
    add_index :personnels, :updated_at
    add_index :personnels, [:last_name, :first_name, :middle_name]
  end

  def self.down
    drop_table :personnels
  end
end
