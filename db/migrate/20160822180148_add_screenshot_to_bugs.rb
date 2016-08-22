class AddScreenshotToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :screenshot, :string
  end
end
