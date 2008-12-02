class Alert < ActiveRecord::Base
  belongs_to :admin

  validates_presence_of :message, :target_id, :target_type, :admin_id

  TargetTypesForDropDown = %w(Student Personnel)

  def target_class
    (self[:target_type] || 'Student').constantize
  end

  def target
    return nil if target_type.blank? and target_id.blank?
    case target_type
    when 'Student'
      Student.find_by_student_id(target_id)
    when 'Personnel'
      Personnel.find_by_personnel_id(target_id)
    else
      raise "Invalid target_type: #{target_type} for #{self.inspect}"
    end
  end
end
