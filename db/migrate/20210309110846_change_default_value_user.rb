class ChangeDefaultValueUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_reviewed, :boolean, default: false
  end
end
