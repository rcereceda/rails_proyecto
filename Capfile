# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/ssh_doctor'

require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/nginx'

set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r } 
