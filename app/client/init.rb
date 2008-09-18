AppRoot = File.dirname(__FILE__)

Dir.glob('vendor/*/lib').each(& $:.method(:<<))

require 'activesupport'

$: << File.join(AppRoot, 'lib')
$: << File.join(AppRoot, 'lib', 'connections')

Dir.glob('lib/*.rb').each(& method(:require))
Dir.glob('lib/connections/*.rb').each(& method(:require))
