class IndexPersonnelOnPersonnelId < ActiveRecord::Migration
  def self.up
    add_index :personnels, :personnel_id, :unique => true
  end

  def self.down
    remove_index :personnels, :personnel_id
  end
end
