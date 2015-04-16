class Task < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments, dependent: :destroy
  validates :description, presence: true
  belongs_to :project
end
