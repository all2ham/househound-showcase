# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/rvm'

# Includes default deployment tasks
require 'capistrano/deploy'

# Rails specific libraries
require 'capistrano/rails'
require 'capistrano/secrets_yml'
# require 'capistrano/faster_assets'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
