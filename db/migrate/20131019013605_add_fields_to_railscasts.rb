class AddFieldsToRailscasts < ActiveRecord::Migration
  def change
    add_column :railscasts, :pro, :boolean, default: false
    add_column :railscasts, :revised, :boolean, default: false
  end
end
