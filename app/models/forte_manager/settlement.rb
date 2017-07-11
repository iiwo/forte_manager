module ForteManager
  class Settlement < ApplicationRecord
    belongs_to(
      :parent_transaction,
      foreign_key: :transaction_id,
      primary_key: :transaction_id,
      class_name: 'ForteManager::Transaction',
      optional: true
    )

    def initialize_with(hash:)
      hash.each do |key, value|
        self[key] = value if has_attribute?(key)
      end
      self
    end
  end
end
