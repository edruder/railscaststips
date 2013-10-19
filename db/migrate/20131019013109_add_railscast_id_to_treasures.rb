class AddRailscastIdToTreasures < ActiveRecord::Migration
  def change
    add_reference :treasures, :railscast, index: true
  end
end
