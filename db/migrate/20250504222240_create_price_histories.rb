class CreatePriceHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :price_histories do |t|
      t.references :cryptocurrency, null: false, foreign_key: true
      t.decimal :price
      t.datetime :timestamp

      t.timestamps
    end
  end
end
