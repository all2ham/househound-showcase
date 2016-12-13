namespace :push do
  desc "Test Push Notification"
  task :test => [:environment] do
    n = Rpush::Apns::Notification.new
    n.app = Rpush::Apns::App.find_by_name("house_hound")
    n.device_token = "d0fdde307b90f3235dc7b205eecd5a14a02db89eb1498abcaa18f3136fadc87a"
    n.alert = "Hi HouseHound!"
    n.save!
  end

  desc "Create Sandbox App for push notifications"
  task :create_sandbox_app => [:environment] do
    unless Rpush::Apns::App.find_by_name(ENV['PUSH_APP_NAME'])
      app = Rpush::Apns::App.new
      app.name = ENV['PUSH_APP_NAME']
      app.certificate = File.read(Rails.root.join('lib', 'push', 'hh_sandbox.pem'))
      app.environment = "sandbox" # APNs environment.
      app.password = "listit4me"
      app.connections = 1
      app.save!
    end
  end

end
