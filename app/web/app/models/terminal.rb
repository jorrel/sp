class Terminal < ActiveRecord::Base
  validates_presence_of :name, :ip_address, :college

  octet = /[01]?[0-9]{1,2}|2[0-4][0-9]|25[0-5]/
  IPv4_Address = /^(#{octet}\.){3}#{octet}$/
  validates_format_of :ip_address, :with => IPv4_Address
end
