# ForteManager
Client/server management UI for Forte

## Usage
Client
```ruby
# initializers/forte_manager.rb
ForteManager.setup do |config|
  config.secret_token = ENV['FORTE_MANAGER_TOKEN']
  config.api_url = ENV['FORTE_MANAGER_API_URL']
  config.client = true  
end
```

Server
```ruby
# initializers/forte_manager.rb
ForteManager.setup do |config|
  config.secret_token = ENV['FORTE_MANAGER_TOKEN']
  config.server = true  
end

# config/routes.rb
mount ForteManager::Engine => '/forte_manager'
```

API url will be: 
```shell
https://yourdomain.com/forte_manager/api
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'forte_manager'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install forte_manager
```
