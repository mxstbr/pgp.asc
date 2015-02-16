class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.datetime :valid_until
      t.boolean :deleted

      t.timestamps null: false
    end
  end
end
