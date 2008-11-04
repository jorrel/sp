class Personnel < ActiveRecord::Base
  fake_attrs {
    {
      :first_name => Faker::Name.first_name,
      :last_name => Faker::Name.last_name,
      :personnel_id => Faker.numerify("#{(1990..2008).to_a.rand}#####")
    }
  }

  class << self
    def to_drop_down
      find(:all, :select => 'personnel_id, first_name, last_name',
                 :order => 'last_name, first_name').collect do |p|
        ["#{p.first_name} #{p.last_name} (#{p.personnel_id})", p.personnel_id]
      end
    end
  end
end
