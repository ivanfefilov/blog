class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_length_of :body, :maximum => 1024

  belongs_to :user
  has_many :comments, :dependent => :destroy

  default_scope :order => 'created_at'

  attr_accessible :user_id, :title, :body
end
