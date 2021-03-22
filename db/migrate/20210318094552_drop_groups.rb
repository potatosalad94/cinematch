class DropGroups < ActiveRecord::Migration[6.1]
  def change
    drop_table :watchers
    drop_table :groups
  end
end
