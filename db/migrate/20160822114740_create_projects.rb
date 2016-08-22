class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.foreign_key :users, :column => 'manager_id'

      t.timestamps null: false
    end
  end
end
