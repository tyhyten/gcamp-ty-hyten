class User < ActiveRecord::Base

  def full_name
  "#{first_name} #{last_name}"
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true, :on => :create

  has_secure_password

end
