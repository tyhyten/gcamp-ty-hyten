class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  enum role: [:member, :owner]
  validates_presence_of :user
  validates :user_id, presence: true, uniqueness: {scope: :project_id, message: "has already been added to this project."}
end
