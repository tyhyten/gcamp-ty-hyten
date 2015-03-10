class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  enum role: [:member, :owner]
  validates_presence_of :user
  validates_uniqueness_of :user
end
