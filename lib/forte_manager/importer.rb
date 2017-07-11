module ForteManager
  class Importer
    def initialize(resource:, model:, id:, filter: {})
      self.resource = resource
      self.model = model
      self.filter = filter
      self.id = id
    end

    def call
      import
    end

    private

      attr_accessor :resource, :model, :id, :filter

      def import
        page = ForteManager::Page.new(resource: resource, filter: filter)

        while page
          page.call
          process_items(items: page.call[:results])
          page = page.next_page
        end
      end

      def process_items(items:)
        items.each do |item|
          instance = model.find_by(id => item[id]) ||
            model.new
          instance.initialize_with(hash: item).save!
        end
      end
  end
end
