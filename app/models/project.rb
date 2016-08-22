class Project < ActiveRecord::Base
  belongs_to :manager, :class_name => 'User', :foreign_key => 'manager_id'
  has_one :team
  has_many :bugs
  has_many :tasks

  validates :title, presence: true
  validates :description, presence: true
  validates_associated :team
  validates_associated :bugs
  validates_associated :tasks
  validates_associated :manager
end
