class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :value

      t.timestamps
    end

    add_index :scores, :user_id
    add_index :scores, :post_id
  end

  def self.down
    drop_table :scores
  end
end
