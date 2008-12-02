#
# Set fake attributes for models for
# generating fake records
#

require 'fakerizer'

Personnel.fake_attrs do
  {
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :middle_name => Faker::Name.last_name,
    :personnel_id => Faker.numerify("#{(1990..2008).to_a.rand}#####")
  }
end

Admin.fake_attrs do
  personnel = Personnel.random || Personnel.fake!
  password = personnel.first_name.underscore
  password += Faker.letterify('?' * (6 - password.size)) if password.size < 6 # make sure we have at least six chars for password
  {
    :login => personnel.first_name.underscore,
    :password => password,
    :password_confirmation => password,
    :superadmin => [false,false,false,false,true].rand,
    :personnel_id => personnel.personnel_id
  }
end
def Admin.new_fake # override to set protected attributes
  returning(new(attrs = fake_attrs)) { |f| f.assign_protected_attributes attrs }
end

Terminal.fake_attrs do
  name = ((%w(front-entrance) * 5) + %w(rear-entrance alternate-entrance side-entrance)).rand
  direction = %w(entry exit).rand
  college = %w(CAS CPH CP CD CM CAMP CN SSWC).rand
  {
    :name => "#{name}-#{direction}",
    :description => "#{college} #{name} #{direction}",
    :college => college,
    :ip_address => "192.168.#{(1..255).to_a.rand}.#{(1..255).to_a.rand}"
  }
end

Student.fake_attrs do
  {
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :middle_name => Faker::Name.last_name,
    :student_id => Faker.numerify("#{(2000..2008).to_a.rand}#####")
  }
end

Alert.fake_attrs do
  target_class = [Personnel, Student].rand
  target = target_class.random || target_class.fake!
  admin = Admin.random || Admin.fake!
  {
    :target_type => target_class.name,
    :target_id => target.id,
    :admin_id => admin.id,
    :message => Faker::Lorem.sentences((2..5).to_a.rand).join("\n")
  }
end
