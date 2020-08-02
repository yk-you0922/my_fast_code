class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.string :email, null: false
      t.string :name, null: false
      t.string :image_id
      t.integer :is_support_status, null: false, default: 0

      t.timestamps
    end
  end
end
