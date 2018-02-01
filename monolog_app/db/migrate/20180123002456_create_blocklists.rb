class CreateBlocklists < ActiveRecord::Migration[5.1]
  def change
    create_table :blocklists do |t|
      t.integer :blocker_id
      t.integer :blocked_id

      t.timestamps
    end
    add_index :blocklists, :blocker_id
    add_index :blocklists, :blocked_id
    add_index :blocklists, [:blocker_id, :blocked_id], unique: true
  end
end
