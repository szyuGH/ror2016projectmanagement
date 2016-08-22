class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.belongs_to :manager, :class_name => 'User', :foreign_key => 'manager_id', :references => 'User'

      t.timestamps null: false
    end
  end
end
