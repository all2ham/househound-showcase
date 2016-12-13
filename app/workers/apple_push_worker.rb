class ApplePushWorker < HouseHoundWorker

  def perform(session_id, notification_id)
    session = Session.find(session_id)
    notification = Notification.find(notification_id)

    push = Rpush::Apns::Notification.new

    app = Rpush::Apns::App.find_by_name(Rails.application.secrets[:push][:app_name])

    raise 'No Rpush iOS app has been created' unless app

    push.app = app
    push.device_token = session.push_token
    push.alert = notification.message
    push.data = {
        listing_id: notification.notifiable_id
    }

    push.save!
  end

end