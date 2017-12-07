class AddPictureToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :picture, :string, default: 'top.png'
  end
end
