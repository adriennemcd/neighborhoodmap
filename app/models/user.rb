class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :questions, :through => :posts, dependent: :destroy

  validates :user_name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..20 }
end
