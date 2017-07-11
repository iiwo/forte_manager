module ForteManager
  class TransactionsController < ForteManager::ApplicationController
    def index
      json_request = api_get(endpoint: 'transactions.json')
      json = json_request.body
      transactions = begin
        JSON.parse(json).map { |transaction| ForteManager::NullTransaction.new(transaction) } if json.present?
      end

      total = json_request.headers['Total'].to_i
      per_page = json_request.headers['Per-Page'].to_i
      params[:page] ||= 1
      offset = (params[:page].to_i - 1) * per_page

      filterrific = initialize_filterrific(
        Transaction,
        params[:filterrific],
        select_options: {
          with_status:  JSON.parse(api_get(endpoint: 'transactions/statuses.json').body),
          with_action: JSON.parse(api_get(endpoint: 'transactions/actions.json').body),
          with_response_code: JSON.parse(api_get(endpoint: 'transactions/response_codes.json').body),
          with_type: Transaction.options_for_types
        }
      ) or return
      
      render locals: {
        transactions: Kaminari.paginate_array(
          transactions,
          offset: offset,
          total_count: total,
          limit: per_page
        ),
        filterrific: filterrific
      }
    end

    def api_get(endpoint: 'transactions.json')
      HTTParty.get(
        URI.join(ForteManager.api_url, endpoint),
        query: request.query_parameters.merge(token: ForteManager.secret_token)
      )
    end
  end
end
