class CreateBmrs < ActiveRecord::Migration[8.0]
  def change
    create_table :bmrs do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :formula
      t.float :value

      t.timestamps
    end
  end
end
