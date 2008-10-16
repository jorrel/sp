#
# define application root
#
AppRoot = File.dirname(__FILE__)
ConfigRoot = File.join(AppRoot, 'config')


#
# require vendors
#
Dir.glob('vendor/*/lib').each(& $:.method(:<<))
require 'activesupport'
require 'inline'


#
# require library files
#
Dir.glob('lib/**/*.rb').each(& method(:require))
