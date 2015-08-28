class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name
      t.string :power
      t.string :type

      t.timestamps null: false
    end
    add_index :monsters, :power
    add_index :monsters, :type
  end
end
