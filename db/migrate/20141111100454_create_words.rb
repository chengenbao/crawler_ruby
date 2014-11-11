class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.integer :crawled #未被爬置0，360爬虫爬过置1，baidu爬虫爬过置2

      t.timestamps
    end
    add_index :words, :word, :unique => true
  end
end
