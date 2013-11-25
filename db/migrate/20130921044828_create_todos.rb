class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.integer :user_id, null: false
      t.string :detail, null: false
      t.string :tag_id
      t.integer :priority, default: 1
      t.date :end_date
      t.boolean :deleted, default: false

      t.timestamps
      t.index [:priority, :deleted]
    end
  end
end
