class AddSeverityToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :severity, :integer
  end
end
