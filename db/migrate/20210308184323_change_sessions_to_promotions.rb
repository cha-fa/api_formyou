class ChangeSessionsToPromotions < ActiveRecord::Migration[6.1]
  def change
    rename_table :sessions, :promotions
    rename_column :subscriptions, :session_id, :promotion_id
  end
end
