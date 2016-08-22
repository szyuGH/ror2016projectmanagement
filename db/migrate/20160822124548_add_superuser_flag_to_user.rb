class AddSuperuserFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_superuser, :boolean
  end
end
