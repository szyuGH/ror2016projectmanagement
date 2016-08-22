class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, :class_name => 'Project', :foreign_key => 'manager_id'
  has_many :tasks, :foreign_key => 'developer_id'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :login, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def display_name
    "%s %s <%s>" % [first_name, last_name, login]
  end

  def team_members
    TeamMember.select{|tm| tm.user == self}
  end

  def assigned_projects
    (team_members.map{|tm| tm.team.project} + Project.select{|p| p.manager == self}).uniq{|p| p.id}
  end

  def project_tasks(project)
    project.tasks.select{|t| t.developer == self}
  end

  # returns
  # -2: project is nil
  # -1: user not assigned for project
  # 0: regular developer
  # 1: project admin
  # 2: project manager
  # 3: super_user
  def project_hierarchy?(project)
    return -2 if project.nil?
    return 3 if is_superuser
    return 2 if project.manager == self
    project_team_member = team_members.select{|t| t.team == project.team}.first
    return -1 if project_team_member.nil?
    return 1 if project_team_member.is_admin
    return 0
  end
end
