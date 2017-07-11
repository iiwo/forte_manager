class CreateForteManagerSettlements < ActiveRecord::Migration[5.0]
  def change
    create_table :forte_manager_settlements do |t|
      t.string :settle_id, index: { unique: true } # stl_0dde9c0d-a816-4ed1-9eb1-490207a87c35
      t.string :organization_id, index: true # org_300005
      t.string :location_id, index: true # loc_115161
      t.string :customer_token, index: true # cst_11017799
      t.string :transaction_id, index: true # trn_8bb0c376-8ab9-4351-af7d-991452d21429
      t.string :customer_id, index: true # 45687545
      t.string :order_number, index: true # 000001
      t.string :reference_id, index: true # 0002315
      t.datetime :settle_date # 2014-02-09T00:00:00
      t.string :settle_type, index: true # deposit
      t.string :settle_response_code, index: true # S01
      t.decimal :settle_amount, precision: 8, scale: 2 # 5.4
      t.string :method, index: true # echeck
      t.timestamps
    end
  end
end
