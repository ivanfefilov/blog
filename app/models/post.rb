class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_length_of :body, :maximum => 1024

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :scores, :dependent => :destroy

  default_scope :order => 'created_at DESC'

  attr_accessible :user_id, :title, :body

  def average_score
    return 0 if scores.count.zero?
    scores.map(&:value).sum / scores.count
  end

  def has_rating_from(user)
    scores.first(:conditions => ["user_id = ?", user.id]).present?            
  end

  class << self
    def best
      all.sort { |x,y| x.average_score <=> y.average_score }.reverse.take(3)
    end

    def popular
      all.sort { |x,y| x.comments.count <=> y.comments.count }.reverse.take(3)
    end
  end
end
