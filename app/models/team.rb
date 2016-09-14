class Team < ActiveRecord::Base
  belongs_to :project
  has_many :members, :class_name => 'TeamMember', :dependent => :destroy

  def has_member?(user)
    members.detect{|m| m.user == user} != nil
  end


end
