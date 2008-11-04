class Personnel < ActiveRecord::Base
  fake_attrs {
    {
      :first_name => Faker::Name.first_name,
      :last_name => Faker::Name.last_name,
      :personnel_id => Faker.numerify("#{(1990..2008).to_a.rand}#####")
    }
  }

  validate_uniqness_of :personnel_id

  class << self
    def to_drop_down
      find(:all, :select => 'personnel_id, first_name, last_name',
                 :order => 'last_name, first_name').collect do |p|
        ["#{p.name(true)} (#{p.personnel_id})", p.personnel_id]
      end
    end
  end

  def name(reversed = false)
    if reversed
      "#{last_name}, #{first_name}"
    else
      "#{first_name} #{last_name}"
    end
  end
end
