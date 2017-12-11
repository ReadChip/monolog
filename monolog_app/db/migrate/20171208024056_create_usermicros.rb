class CreateUsermicros < ActiveRecord::Migration[5.1]
  def change
    create_table :usermicros do |t|
      t.references :user, foreign_key: true
      t.string :micro1, default: '1'
      t.string :micro2, default: '2'
      t.string :micro3
      t.string :micro4
      t.string :micro5
      t.string :micro6
      t.string :micro7
      t.string :micro8
      t.string :micro9
      t.string :micro10

      t.timestamps
    end
  end
end