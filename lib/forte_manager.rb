require 'fortenet'
require 'haml-rails'
require 'kaminari'
require 'bootstrap-kaminari-views'
require 'simple_form'
require 'jquery-rails'
require 'sass-rails'
require 'coffee-rails'
require 'filterrific'
require 'api-pagination'
require 'forte_manager/query'
require 'forte_manager/page'
require 'forte_manager/importer'
require 'forte_manager/null_transaction'
require 'forte_manager/engine'

module ForteManager
  mattr_accessor(
    :secret_token,
    :api_url,
    :server,
    :client
  )

  def self.setup
    yield self
  end
end
