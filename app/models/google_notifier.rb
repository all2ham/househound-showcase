# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  message         :text
#  notifiable_id   :integer
#  notifiable_type :string
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class GoogleNotifier < Notification

end
