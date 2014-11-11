class CreateIndexes < ActiveRecord::Migration
  def change
    create_table :indexes do |t|
      t.string :title
      t.string :url
      t.string :sum
      t.string :word

      t.timestamps
    end

    add_index :indexes, :sum, :unique=>true
  end
end
