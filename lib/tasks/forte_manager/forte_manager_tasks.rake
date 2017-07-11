namespace :forte_manager do
  desc 'import all transactions from forte'
  task :import_transactions => :environment do
    ForteManager::Importer.new(
      resource: 'transactions',
      model: ForteManager::Transaction,
      id: :transaction_id
    ).call
  end

  desc 'update transactions from last 10 days'
  task :update_transactions => :environment do
    ForteManager::Importer.new(
      resource: 'transactions',
      model: ForteManager::Transaction,
      id: :transaction_id,
      filter: { start_received_date: Date.today - 10.days}
    ).call
  end
end
