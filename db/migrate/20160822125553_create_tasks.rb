class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :state, :default => 0
      t.integer :progress, :default => 0
      t.belongs_to :developer, :class_name => 'TeamMember'
      t.integer :project_id
      t.date :deadline
      t.datetime :finished_at

      t.timestamps null: false
    end
    add_index :tasks, :project_id

    create_table :bugs_tasks do |t|
      t.belongs_to :bug, index: true
      t.belongs_to :task, index: true
    end
  end
end
