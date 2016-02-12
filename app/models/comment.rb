class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, :maximum => 200

  belongs_to :user
  belongs_to :post

  attr_accessible :user_id, :post_id, :body
end
