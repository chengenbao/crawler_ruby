class CreateWords < ActiveRecord::Migration
  def change
    create_table :word do |t|
      t.string :word
      t.boolean :crawled

      t.timestamps
    end
  end
end
