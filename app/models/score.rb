class Score < ActiveRecord::Base
  validates_presence_of :value
  validates_numericality_of :value, :only_integer => true, :less_than => 6, :greater_than => 0

  belongs_to :user
  belongs_to :post 
end
