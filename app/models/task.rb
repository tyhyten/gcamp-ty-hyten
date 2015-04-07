class Task < ActiveRecord::Base
  has_many :comments
  has_many :users, through: :comments
  validates :description, presence: true
  belongs_to :project
end
