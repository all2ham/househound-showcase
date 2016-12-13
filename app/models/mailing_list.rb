class MailingList < ActiveRecord::Base
  validates :email, uniqueness: true, email: true
end
