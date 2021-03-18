class AddOwnerToEvents < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :owner, foreign_key: { to_table: :users }
  end
end
