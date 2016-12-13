desc 'Seed things throughout the application'
namespace :seeds do
  namespace :admins do
    desc 'Generate admins for the application'
    task create: :environment do
      load Rails.root.join('lib', 'tasks', 'seeds', 'admins.rb')
      puts 'Created admins'
    end
  end
end
