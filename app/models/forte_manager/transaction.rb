module ForteManager
  class Transaction < ApplicationRecord
    SEARCHABLE = %w[first_name last_name transaction_id customer_token]
    has_many :settlements, primary_key: :transaction_id, class_name: 'ForteManager::Settlement'

    filterrific(
      default_filter_params: { },
      available_filters: [
        :search_query,
        :with_status,
        :with_action,
        :with_response_code,
        :with_type
      ]
    )

    scope :search_query, lambda { |query|
      query_string = SEARCHABLE.map { |field| "forte_manager_transactions.#{field} LIKE '%#{query}%'" }.join(' OR ')
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
        .order('forte_manager_transactions.received_date desc, forte_manager_transactions.customer_token')
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
  end
end
