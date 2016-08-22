class Project < ActiveRecord::Base
  belongs_to :manager, :class_name => 'User', :foreign_key => 'manager_id'
end
