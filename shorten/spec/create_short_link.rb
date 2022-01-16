require_relative '../lib/create_short_link'

RSpec.describe CreateShortLink do
  it 'should create a 8 byte short link' do
    link = CreateShortLink.new(url: 'http://www.google.com')
    expect(link.short_link.length).to be 8
  end
end
