class Student < ActiveRecord::Base
  RecordStatus = {
    :unconfirmed_freshman   =>  'U',
    :confirmed_freshman     =>  'F',
    :regular_student        =>  'E', # Enrolled Regular Student
    :cross_registrant       =>  'C',
    :loa                    =>  'L', # L.O.A.
    :awol                   =>  'W', # A.W.O.L.
    :alumni                 =>  'A'
  }

  validate_presence_of :student_id, :first_name, :last_name
  validate_uniqueness_of :student_id

  class << self
    def find_with_student_id(*args, &block)
      if args.size == 1 and String === args.first and args.first =~ /^\d{4}-\d{5}$/
        find_by_student_id!(*args)
      else
        find_without_student_id(*args, &block)
      end
    end
    alias_method_chain :find, :student_id

    def find_by_student_id!(student_id)
      if student = find_every(:conditions => {:student_id => student_id}).first
        student
      else
        raise ActiveRecord::RecordNotFound, "No student with student id of #{student_id}"
      end
    end
  end

  def to_param
    student_id || id
  end
end
