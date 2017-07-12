module ForteManager
  class NullTransaction
    include ActiveModel::Model
    
    attr_accessor(
      :id,
      :created_at,
      :updated_at,
      :transaction_id,
      :organization_id,
      :location_id,
      :customer_token,
      :customer_id,
      :order_number,
      :reference_id,
      :status,
      :action,
      :authorization_amount,
      :authorization_code,
      :entered_by,
      :received_date,
      :first_name,
      :last_name,
      :company_name,
      :response_code
    )

    def full_name
      [first_name, last_name].join(' ')
    end

    def display_date
      DateTime.parse(received_date).strftime("%m/%d/%y %I:%M %p")
    end
  end
end
