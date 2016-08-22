class CreateBug < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.integer :state
      t.integer :project_id

      t.timestamps null: false
    end
    add_index :bugs, :project_id
  end
end
