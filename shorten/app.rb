require 'roda'

require_relative './lib/create_short_link'

class App < Roda
  plugin :json_parser
  plugin :json

  route do |r|
    r.is 'create' do
      r.post do
        response['Content-Type'] = 'application/json'
        puts r.params
        link = CreateShortLink.new(url: r.params['url'])
        { link: link.short_link }.to_json
      end
    end
  end
end
