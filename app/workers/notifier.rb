class Notifier
  Rpush.embed
  @queue = :notification_queue
  def self.perform(message, listing_id)
    self.apns_send(message, listing_id)
  end

  def self.apns_send(message, listing_id)
    if listing = Listing.find(listing_id)
      devices = listing.devices.where(os: 'ios')
      devices.each do |d|
        n = Rpush::Apns::Notification.new
        n.app = Rpush::Apns::App.find_by_name(Rails.application.secrets[:push][:app_name])
        n.device_token = d.push_uid
        n.alert = message
        n.save!
      end
    end
  end
end
