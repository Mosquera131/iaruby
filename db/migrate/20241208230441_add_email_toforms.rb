class AddEmailToforms < ActiveRecord::Migration[7.2]
  def change
    add_column :forms, :email, :string, null: true
  end
end
