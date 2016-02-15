class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :name

  validates_presence_of :name

  has_many :posts, :dependent => :destroy
  has_many :scores, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  def is_creator_of(post)
    id == post.user_id
  end
end
