class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :name	
      t.text :content
      t.timestamps
    end
  end
end
