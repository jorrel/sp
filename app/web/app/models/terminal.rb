class Terminal < ActiveRecord::Base
  fake_attrs {
    name = ((%w(front-entrance) * 5) + %w(rear-entrance alternate-entrance side-entrance)).rand
    direction = %w(entry exit).rand
    college = %w(CAS CPH CP CD CM CAMP CN SSWC).rand
    {
      :name => "#{name}-#{direction}",
      :description => "#{college} #{name} #{direction}",
      :college => college,
      :ip_address => "192.168.#{(1..255).to_a.rand}.#{(1..255).to_a.rand}"
    }
  }

  validates_presence_of :name, :ip_address, :college
  validates_uniqueness_of :ip_address
  validates_uniqueness_of :name, :scope => :college

  octet = /[01]?[0-9]{1,2}|2[0-4][0-9]|25[0-5]/
  IPv4_Address = /^(#{octet}\.){3}#{octet}$/
  validates_format_of :ip_address, :with => IPv4_Address
end
