class ChangeColumnContacts < ActiveRecord::Migration[5.2]
  def change
    change_column :contacts, :title, :string, null: false
    change_column :contacts, :body, :string, null: false
  end
end
