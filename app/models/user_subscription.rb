class UserSubscription < ActiveRecord::Base
  validates :feed_id, presence: true
  validates :user_id, presence: true

  belongs_to :feed
  belongs_to :user
end
