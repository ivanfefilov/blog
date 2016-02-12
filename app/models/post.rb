class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_length_of :body, :maximum => 1024

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :scores, :dependent => :destroy

  default_scope :order => 'created_at'

  attr_accessible :user_id, :title, :body

  def average_score
    scores.map(&:value).sum / scores.map(&:value).count
  end

  class << self
    def best_posts
      all.sort { |x,y| x.average_score <=> y.average_score }.reverse.take(3)
    end

    def popular_posts
      all.sort { |x,y| x.comments.count <=> y.comments.count }.reverse.take(3)
    end
  end
end
