module ForteManager
  class Settlement < ApplicationRecord
    if Rails::VERSION::MAJOR > 4
      belongs_to(
        :parent_transaction,
        foreign_key: :transaction_id,
        primary_key: :transaction_id,
        class_name: 'ForteManager::Transaction',
        optional: true
      )
    else
      belongs_to(
        :parent_transaction,
        foreign_key: :transaction_id,
        primary_key: :transaction_id,
        class_name: 'ForteManager::Transaction'
      )
    end

    def initialize_with(hash:)
      hash.each do |key, value|
        self[key] = value if has_attribute?(key)
      end
      self
    end
  end
end
