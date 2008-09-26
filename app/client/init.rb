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

# $: << File.join(AppRoot, 'lib')
# $: << File.join(AppRoot, 'lib', 'connections')
# $: << File.join(AppRoot, 'lib', 'gui')

# Dir.glob('lib/*.rb').each(& method(:require))
# Dir.glob('lib/connections/*.rb').each(& method(:require))
