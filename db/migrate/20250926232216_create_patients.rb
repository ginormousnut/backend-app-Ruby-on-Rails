class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.date :birthday
      t.string :gender
      t.integer :height
      t.integer :weight

      t.timestamps
    end
    add_index :patients, [ :first_name, :last_name, :middle_name, :birthday ], unique: true, name: 'index_patients_on_full_name_and_birthday'
  end
end
