# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#  active                 :boolean          default("false")
#

class User < ActiveRecord::Base

  module Groups
    ALL = %w(Agent Admin Buyer)
    ADMIN = "Admin"
    AGENT = "Agent"
    BUYER = "Buyer"
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  belongs_to :access_code
  has_one :agent_profile, dependent: :destroy
  has_one :subscription
  has_many :listings, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :listing_follows, source: :listing, through: :follows
  has_many :sessions, dependent: :destroy
  has_many :user_room_ratings, dependent: :destroy

  before_validation :default_values

  validates :role, presence: true, inclusion: { in: Groups::ALL }
  validates :email, presence: true, email: true

  validates_associated :sessions

  validates_each :listings do |user, attr, value|
    user.errors.add attr, "Too many listings for user" if user.listings.size > Listing::LIMIT
  end

  scope :buyer, -> { where(role: Groups::BUYER) }

  def self.new_buyer(options = {})
    user = User.create!(options.merge!({
      role: User::Groups::BUYER,
    }))
    return user
  end

  def default_values
    self.active = true
    if self.is_agent?
      self.agent_profile ||= AgentProfile.new
    end
  end

  def listing_in_progress
    listings.not_active.take
  end

  def is_admin?
    self.role == Groups::ADMIN
  end

  def is_agent?
    self.role == Groups::AGENT
  end

  def is_buyer?
    self.role == Groups::BUYER
  end

  def active_for_authentication?
    super
  end

  def is_following?(listing_id)
    Follow.exists?(listing_id: listing_id, user_id: self.id)
  end

  def can_follow?(count = 0)
    self.follow_count + count <= Follow.limit
  end

  def has_active_session?(os)
    return false unless os
    sessions.where(os: os).active.take != nil
  end

  def active_session(os)
    sessions.active_session(os).take
  end

  def follow_count
    follows.count
  end

  def has_active_subscription?
    subscription && subscription.running?
  end

  protected

  # Devise Override
  # Only send Devise confirmation email to Agents
  def send_on_create_confirmation_instructions
    super if self.is_agent?
  end

  # Devise Override
  # Only confirm Agents
  def confirmation_required?
    return false unless self.is_agent?
    super
  end

  private

end
