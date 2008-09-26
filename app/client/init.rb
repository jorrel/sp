#
# define application root
#
AppRoot = File.dirname(__FILE__)


#
# require vendors
#
Dir.glob('vendor/*/lib').each(& $:.method(:<<))
require 'activesupport'


#
# require library files
#
Dir.glob('lib/**/*.rb').each(& method(:require))
