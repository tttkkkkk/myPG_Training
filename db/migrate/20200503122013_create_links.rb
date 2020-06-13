class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.references :micropost, foreign_key: true
      t.timestamps
      t.string :url
    end
  end
end
