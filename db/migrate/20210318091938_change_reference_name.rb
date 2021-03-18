class ChangeReferenceName < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :owner_id, :user_id
  end
end
