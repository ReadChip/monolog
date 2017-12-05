class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, default: "名無し"
  end
end
