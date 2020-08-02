class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :post_id, null: false
      t.integer :genre_id, null: false

      t.timestamps
    end
  end
end
