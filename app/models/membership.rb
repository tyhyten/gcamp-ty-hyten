class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  enum role: [:member, :owner]
  validates_presence_of :user
end
