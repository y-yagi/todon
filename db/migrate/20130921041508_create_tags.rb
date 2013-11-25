class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.string :name
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
