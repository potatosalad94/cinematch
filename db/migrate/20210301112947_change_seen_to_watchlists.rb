class ChangeSeenToWatchlists < ActiveRecord::Migration[6.1]
  def change
    change_column_default :watchlists, :seen, false
  end
end
