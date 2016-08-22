class Task < ActiveRecord::Base
  belongs_to :developer, :class_name => 'User'
  belongs_to :project
  has_and_belongs_to_many :bugs

  accepts_nested_attributes_for :bugs

  validates :project, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  enum state: [:open, :in_process, :finished, :cancelled]

  def claimable?(user)
    project.team.members.detect{|m| m.user == user} != nil
  end
end
