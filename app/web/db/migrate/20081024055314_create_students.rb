class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :student_id, :integer, :unique => true, :null => false
      t.column :first_name, :string, :limit => 30
      t.column :middle_name, :string, :limit => 30
      t.column :last_name, :string, :limit => 30
      t.column :record_status, 'char(1)', :default => Student::RecordStatus[:regular_student]
      t.timestamps
    end
    add_index :students, :student_id
    add_index :students, [:last_name, :first_name, :middle_name]
  end

  def self.down
    drop_table :students
  end
end
