class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.references :hotel, null: false
      t.references :supplier, null: false

      t.timestamps
    end

    add_index :offers, [:hotel_id, :supplier_id], unique: true
  end
end
