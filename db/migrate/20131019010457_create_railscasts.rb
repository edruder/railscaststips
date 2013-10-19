class CreateRailscasts < ActiveRecord::Migration
  def change
    create_table :railscasts do |t|
      t.string :url
      t.string :name
      t.text :description
      t.boolean :railscasts, :pro, default: false
      t.boolean :railscasts, :revised, default: false
      t.string :duration
      t.integer :position
      t.string :permalink

      t.timestamps
    end
  end
end
