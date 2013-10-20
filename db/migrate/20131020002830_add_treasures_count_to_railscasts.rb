class AddTreasuresCountToRailscasts < ActiveRecord::Migration
  def change
    add_column :railscasts, :treasures_count, :integer, default: 0
  end
end
