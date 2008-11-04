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

  #
  # Inspect and print a list of available methods of the object
  #
  def inspector(object, description = '')
    dev {
      puts "\n====== INSPECTOR ======"
      puts description unless description.blank?
      puts "inspect: "
      puts object.inspect
      puts "methods: "
      puts (object.methods.sort - Object.methods).inspect
      puts "=======================\n"
    }
  end

  def dev
    yield if $environment == :dev
  end

  def event(message)
    if block_given?
      begin
        print message + ' ... '
        yield
      rescue Object => e
        puts 'failed'
        raise e
      else
        puts 'done'
      end
    else
      puts message
    end
  end
  alias :e :event
end

