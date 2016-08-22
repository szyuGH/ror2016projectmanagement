class Bug < ActiveRecord::Base
  belongs_to :project

  validates :title, presence: true
  validates :description, presence: true
  validates :severity, presence: true

  enum state: [:open, :fixed, :rejected]
  enum severity: [:unimportant, :minor, :major, :critical]
end
