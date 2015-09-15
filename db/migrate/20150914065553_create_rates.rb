class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.float :ask, null: false, default: 0.0, unsign: true
      t.float :bid, null: false, default: 0.0, unsign: true
      t.timestamp :parsed_at, null: false

      t.timestamps null: false
    end

    add_index :rates, :parsed_at, name: :rates_parsed_at
    add_index :rates, :from, name: :rates_from
    add_index :rates, :to, name: :rates_to
    add_index :rates, [ :from, :to ], name: :rates_from_to
  end
end
