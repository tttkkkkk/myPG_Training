class AddCheckToMicorpost < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :check, :integer,default: 0
  end
end
