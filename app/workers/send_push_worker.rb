class SendPushWorker < HouseHoundWorker

  def perform(notification_id)
    listing = Notification.find(notification_id).notifiable

    follows = listing.follows.includes(user: [:sessions])

    follows.each do |follow|
      follow.user.sessions.each do |session|
        case session.os
          when Session::IOS
            ApplePushWorker.perform_async(session.id, notification_id)
        end
      end
    end
  end
end
