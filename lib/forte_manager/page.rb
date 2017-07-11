module ForteManager
  class Page
    def initialize(client: Fortenet::Client.new, resource: 'transactions', params: {}, filter: {})
      self.client = client
      self.resource = resource
      self.params = { page_index: 0, page_size: 1000, orderby: 'received_date desc' }.merge(params)
      self.filter = filter
    end

    def call
      client.find(resource, query_string)
      client.parsed_response
    end

    def next_page
      next_page_object if next?
    end

    private

      attr_accessor :client, :params, :filter, :resource

      def next_page_object
        ForteManager::Page.new(
          client: client,
          resource: resource,
          params: params.merge(page_index: params[:page_index] + 1),
          filter: filter
        )
      end

      def next?
        client.parsed_response[:links][:next]
      end

      def query_string
        params.merge(filter: filter_query).to_query
      end

      def filter_query
        filter.tap do |f|
          f.each { |key, value| f[key] = "'#{value.to_date.strftime('%F')}'" if (value.is_a?(Date) || value.is_a?(Time))}
        end.map { |key, value| "#{key} eq #{value}" }.join(' and ')
      end
  end
end
