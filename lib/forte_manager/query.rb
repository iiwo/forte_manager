module ForteManager
  class Query
    def initialize(params:, filter: nil)
      self.params = params
      self.filter = filter
    end

    def call
      params.merge(filter: filter_query).to_query
    end

    private
    
      attr_accessor :params, :filter

      def filter_query
        filter.tap do |f|
          f.each { |key, value| f[key] = "'#{value.to_date.strftime('%F')}'" if (value.is_a?(Date) || value.is_a?(Time))}
        end.map { |key, value| "#{key} eq #{value}" }.join(' and ')
      end
  end
end
