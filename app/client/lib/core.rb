#
# Core extension library
#

module Kernel
  # debugger/breakpointer
  def debug(b)
    b = (Binding === b) ? b : b.send(:binding)
    puts "DEBUGGER ON!"

    while true do
      print "debug: "
      command = gets
      if command.chomp == 'exit'
        return
      else
        begin
          result = eval(command, b).inspect
        rescue Object => e
          puts "command: #{command}"
          puts e
          puts (e.methods.sort - Object.methods).inspect
          e.backtrace.each(& method(:puts))
        else
          puts "=> " + result
        end
      end
    end
  end
end
