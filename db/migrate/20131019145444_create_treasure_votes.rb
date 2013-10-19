class CreateTreasureVotes < ActiveRecord::Migration
  def change
    create_table :treasure_votes do |t|
      t.integer :value
      t.references :user, index: true
      t.references :treasure, index: true

      t.timestamps
    end
  end
end
