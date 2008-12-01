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
  RecordStatusForDropDown = RecordStatus.to_a.map{ |(l,v)| [l.humanize, v] }.sort
  StudentIDRange = (199900000..300000000)

  validates_presence_of :student_id, :first_name, :last_name
  validates_uniqueness_of :student_id
  validates_numericality_of :student_id, :message => 'should contain only numbers'
  validates_inclusion_of :student_id, :in => StudentIDRange, :message => 'invalid'

  class << self
    def find_with_student_id(*args, &block)
      if args.size == 1 and String === args.first and args.first =~ /^\d{4}-\d{5}$/
        args.first.gsub!(/-/,'')
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
    (student_id || id).to_s
  end

  def name(reversed = false)
    if reversed
      "#{last_name}, #{first_name}"
    else
      "#{first_name} #{last_name}"
    end
  end
end
