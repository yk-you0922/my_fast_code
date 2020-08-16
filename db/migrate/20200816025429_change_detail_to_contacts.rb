class ChangeDetailToContacts < ActiveRecord::Migration[5.2]
  def up
    change_column :contacts, :name, :string, null: false, default: ""
    change_column :contacts, :email, :string, null: false, default: ""
  end

  def down
    change_column :contacts, :name, :string, null: false
    change_column :contacts, :email, :string, null: false
  end
end
