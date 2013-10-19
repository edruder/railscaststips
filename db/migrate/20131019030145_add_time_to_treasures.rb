class AddTimeToTreasures < ActiveRecord::Migration
  def change
    add_column :treasures, :time, :time
  end
end
