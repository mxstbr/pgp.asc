class AddPersonIdToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :person_id, :integer
    add_index :keys, :person_id
  end
end
