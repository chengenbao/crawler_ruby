class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :page, :limit => 1000000 # 1MB
      t.string :sum
      t.string :word
      t.integer :indexed

      t.timestamps
    end
    add_index :pages, :sum, :unique => true
  end
end
