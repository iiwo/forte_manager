module ForteManager
  module Api
    class TransactionsController < ActionController::API
      include Rails::Pagination
      
      before_action :authenticate!

      def index
        filterrific = initialize_filterrific(
          Transaction,
          params[:filterrific],
          select_options: {
            with_status: Transaction.options_for_status,
            with_action: Transaction.options_for_action,
            with_response_code: Transaction.options_for_response_code,
            with_type: Transaction.options_for_types
          }
        ) or return
        transactions = filterrific.find

        paginate json: transactions
      end

      def statuses
        render json: Transaction.options_for_status
      end

      def actions
        render json: Transaction.options_for_action
      end

      def response_codes
        render json: Transaction.options_for_response_code
      end

      private
      
        def authenticate!
          unless params[:token] == ForteManager.secret_token
            head(401)
            false
          end
        end
    end
  end
end