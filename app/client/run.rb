require 'init'

begin
  Client::GUI.using(Client.new).start
rescue ::StandardError => e
  puts e
  e.application_backtrace.each { |l| puts l }
  exit(1)
end
