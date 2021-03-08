class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :student, null: false, index: true
      t.integer :note
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
