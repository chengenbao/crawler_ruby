class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :page
      t.string :sum
      t.boolean :indexed

      t.timestamps
    end
  end
end
