# == Schema Information
#
# Table name: access_codes
#
#  id           :integer          not null, primary key
#  batch_number :integer
#  access_code  :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AccessCode < ActiveRecord::Base

  has_paper_trail

  has_many :users

  validates :code, length: { minimum: 6 }
  validates :limit, numericality: { greater_than: 0 }
  validates :notes, presence: true

  before_destroy :can_destroy?

  def consumed?
    remaining == 0
  end

  def remaining
    limit - users.count
  end

  def can_destroy?
    users.empty?
  end
end
