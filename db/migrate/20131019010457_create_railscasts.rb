class CreateRailscasts < ActiveRecord::Migration
  def change
    create_table :railscasts do |t|
      t.string :url
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
