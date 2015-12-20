class CreateWord < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :english
      t.string :phonetic
      t.timestamps
    end

    add_index :words, :english, unique: true
  end
end
