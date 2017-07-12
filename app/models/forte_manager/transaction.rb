module ForteManager
  class Transaction < ApplicationRecord
    SEARCHABLE = [
      'forte_manager_transactions.first_name',
      'forte_manager_transactions.last_name',
      'forte_manager_transactions.transaction_id',
      'forte_manager_transactions.customer_token',
      "concat(forte_manager_transactions.first_name,' ', forte_manager_transactions.last_name)"
    ]
    has_many :settlements, primary_key: :transaction_id, class_name: 'ForteManager::Settlement'

    filterrific(
      default_filter_params: { sorted_by: 'received_date desc' },
      available_filters: [
        :search_query,
        :with_status,
        :with_action,
        :with_response_code,
        :with_type,
        :sorted_by
      ]
    )

    scope :search_query, lambda { |query|
      text_fields = SEARCHABLE.map { |field| "#{field} iLIKE '%#{query}%'" }
      numeric_fields = ["CAST(forte_manager_transactions.authorization_amount AS TEXT) LIKE '#{query}%'"]
      query_string = (text_fields + numeric_fields).join(' OR ')
      where(query_string)
    }

    scope :with_status, lambda { |status|
      where(status: status)
    }

    scope :with_action, lambda { |action|
      where(action: action)
    }

    scope :with_response_code, lambda { |code|
      where(response_code: code)
    }

    scope :with_type, lambda { |_type|
      joins('left outer join forte_manager_transactions as sec on forte_manager_transactions.customer_token = sec.customer_token')       
        .where("abs(DATE_PART('day', forte_manager_transactions.received_date - sec.received_date)) < 15")
        .where('forte_manager_transactions.action': %w[sale force])
        .where('sec.action': %w[sale force])
        .where('forte_manager_transactions.status': %w[funded settling complete ready])
        .where('sec.status': %w[funded settling complete ready])
        .where('forte_manager_transactions.authorization_amount = sec.authorization_amount')
        .where.not('forte_manager_transactions.transaction_id = sec.transaction_id')
        .distinct
    }

    scope :sorted_by, lambda { |sort_option|
      order(sort_option)
    }

    def full_name
      [first_name, last_name].join(' ')
    end

    def initialize_with(hash:)
      hash.each do |key, value|
        self[key] = value if has_attribute?(key)
      end
      self.response_code = hash[:response][:response_code] if hash[:response].present?
      if hash[:billing_address].present?
        self.first_name = hash[:billing_address][:first_name]
        self.last_name = hash[:billing_address][:last_name]
      end
      self
    end

    def self.options_for_status
      group(:status).pluck(:status)
    end

    def self.options_for_action
      group(:action).pluck(:action)
    end

    def self.options_for_response_code
      group(:response_code).pluck(:response_code)
    end

    def self.options_for_types
      %w[duplicates]
    end

    def self.options_for_sorted_by
      [ ['Created Date (desc)', 'received_date desc'],
        ['Last Name (asc)', 'last_name asc'],
        ['Amount (desc)', 'authorization_amount desc'],
        ['Customer Token', 'customer_token desc']]
    end
  end
end
