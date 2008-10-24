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
end
