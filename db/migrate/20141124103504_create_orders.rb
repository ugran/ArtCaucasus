class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :tracking_number
      t.string :status
      t.string :p_invoice_number
      t.string :p_gross_amount
      t.string :p_auth_amount
      t.string :p_shipping
      t.string :p_auth_expiration_date
      t.string :p_address_status
      t.string :p_payer_id
      t.string :p_address_street
      t.string :p_payment_date
      t.string :p_zipcode
      t.string :p_paypal_name
      t.string :p_paypal_lastname
      t.string :p_shipping_name
      t.string :p_custom
      t.string :p_country
      t.string :p_city
      t.string :p_email
      t.string :p_txn_id
      t.string :p_state
      t.string :p_item_name
      t.string :p_item_number
      t.string :p_ipn_tracking_id
      t.string :p_contact_phone
      t.text :description
      t.text :additional_info

      t.timestamps
    end
  end
end
