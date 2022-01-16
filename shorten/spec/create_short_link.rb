require_relative '../lib/create_short_link'

RSpec.describe CreateShortLink do
  it 'should create a 8 byte short link' do
    link = CreateShortLink.new(url: 'http://www.google.com')
    expect(link.short_link.length).to be 8
  end

  it 'should create new short link on retry' do
    link = CreateShortLink.new(url: 'http://www.wikipedia.com')
    first_short_link = link.short_link
    link.recreate_on_collision { |short_link| short_link == first_short_link }
    new_short_link = link.short_link
    expect(new_short_link).not_to eq first_short_link
  end
end
