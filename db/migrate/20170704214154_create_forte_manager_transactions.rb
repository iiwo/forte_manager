class CreateForteManagerTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :forte_manager_transactions do |t|
      t.string :transaction_id, index: { unique: true }  # trn_2c2261e9-e506-4178-810b-699614bf741e
      t.string :organization_id, index: true # org_300005
      t.string :location_id, index: true # loc_115161
      t.string :customer_token, index: true # cst_bzGojNYBZ0e62xYaPWO-_A
      t.string :customer_id, index: true # 456987
      t.string :order_number, index: true # 3330256
      t.string :reference_id, index: true # 4569874
      t.string :status, index: true # ready
      t.string :action, index: true # sale
      t.decimal :authorization_amount, precision: 8, scale: 2 # 0.23
      t.string :authorization_code # 86697776
      t.string :entered_by # Griff Tannen
      t.datetime :received_date # 2015-01-02T04:18:33.417
      t.string :first_name, index: true # Michael
      t.string :last_name, index: true # Fox
      t.string :company_name, index: true # MJF Productions
      t.string :response_code, index: true # A01
      t.timestamps
    end
  end
end
