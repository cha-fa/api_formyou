class AddFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_approved, :boolean, default: false
    add_column :users, :role, :string, default: "student"
  end
end
