class Bug < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, :class_name => 'User'
  has_and_belongs_to_many :tasks

  validates :title, presence: true
  validates :description, presence: true
  validates :severity, presence: true

  enum state: [:open, :fixed, :rejected]
  enum severity: [:unimportant, :minor, :major, :critical]
end
