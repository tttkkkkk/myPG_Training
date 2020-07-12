class AddKindToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :kind, :integer, :default => 0
  end
end
