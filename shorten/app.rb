require 'roda'

require_relative 'models'
require_relative './lib/create_short_link'

class App < Roda
  plugin :json_parser
  plugin :json
  Sequel::Model.plugin :validation_helpers
  Sequel::Model.plugin :timestamps, update_on_create: true

  route do |r|
    r.is 'create' do
      r.post do
        response['Content-Type'] = 'application/json'
        link = CreateShortLink.new(url: r.params['url'])
        link.save
        { link: link.short_link }.to_json
      end
    end
  end
end
