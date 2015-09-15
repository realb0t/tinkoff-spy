class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :currency, null: false
      t.string :deal_type, null: false
      t.string :sign, null: false
      t.float :value, null: false, default: 0.0, unsign: true
      t.string :email, null: false

      t.timestamps null: false
    end

    add_index :alerts, [ :currency, :deal_type, :sign, :value ]
  end
end
