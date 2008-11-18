class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.column :target_id, :integer
      t.column :target_type, :string, :limit => 30
      t.column :admin_id, :integer
      t.column :message, :string, :limit => 255
      t.timestamps
    end
    add_index :alerts, [:target_type, :target_id]
    add_index :alerts, :admin_id
    add_index :alerts, :updated_at
  end

  def self.down
    drop_table :alerts
  end
end
