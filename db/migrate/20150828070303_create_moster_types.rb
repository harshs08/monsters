class CreateMosterTypes < ActiveRecord::Migration
  def change
    create_table :moster_types do |t|
      t.string :name
      t.string :feature
      t.integer :rank

      t.timestamps null: false
    end
  end
end
