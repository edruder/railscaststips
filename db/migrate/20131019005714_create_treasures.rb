class CreateTreasures < ActiveRecord::Migration
  def change
    create_table :treasures do |t|
      t.text :description, limit: 150

      t.timestamps
    end
  end
end
