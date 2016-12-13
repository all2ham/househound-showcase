# == Schema Information
#
# Table name: sessions
#
#  id           :integer          not null, primary key
#  access_token :string(255)
#  expires_at   :datetime
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  uuid         :string(255)
#  push_token   :string(255)
#  os           :string(255)
#  os_version   :string(255)
#

class Session < ActiveRecord::Base
  ANDROID = 'android'
  IOS = 'ios'
  OS_TYPES = [ANDROID, IOS]

  belongs_to :user

  before_validation :generate_session

  validates :access_token, presence: true, length: { minimum: 16 }, uniqueness: true
  validates :uuid, presence: true, uniqueness: true, allow_nil: false
  validates :os, inclusion: Session::OS_TYPES

  scope :by_push_token, -> (token) { where(push_token: token).take }
  scope :active, -> { where("expires_at > ?", DateTime.now)}
  scope :active_session, -> (os) { where(os: os).active }

  before_create do
    self.expires_at = DateTime.now + 30.days
  end

  before_save :strip_push_token, if: :push_token_changed?

  def active?
    self.expires_at > DateTime.now
  end

  def expired?
    !self.active?
  end

  private

  # Generate API token
  def generate_session
    return unless self.access_token.blank?
    begin
      self.access_token = SecureRandom.urlsafe_base64(32)
    end while self.class.exists?(access_token: access_token)
  end

  def strip_push_token
    case self.os
      when Session::IOS
        self.push_token.gsub!(/\s+/, '')
        self.push_token.gsub!(/[<>]/, '')
    end
    if self.push_token.length == 0
      self.push_token = nil
    end
  end
end
