class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :url
      t.string :mail
      t.string :confirm_hash
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
