# A sample Guardfile
# More info at https://github.com/guard/guard#readme
# failed_mode: :none,
interactor :simple

guard :rspec, cmd: 'spring rspec',  all_on_start: false, all_after_pass: false do

  watch(%r{^spec/models/.+_spec\.rb$})
  watch(%r{^spec/helpers/.+_spec\.rb$})
  watch(%r{^spec/services/.+_spec\.rb$})
  watch(%r{^spec/interactions/.+_spec\.rb$})
  watch(%r{^spec/routing/.+_spec\.rb$})
  watch(%r{^spec/requests/.+_spec\.rb$})
  watch(%r{^spec/views/.+_spec\.rb$})
  watch(%r{^spec/controllers/.+_spec\.rb$})


  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/features/#{m[1]}_spec.rb" }
end
