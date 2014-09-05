require 'spec_helper'

describe HasOffersV3::Client do

  describe '#base_uri' do

    let(:configuration_to_default_host) { HasOffersV3::Configuration.new }
    let(:config_for_proxy) {
      result = HasOffersV3::Configuration.new
      result.host = 'api.applift.com'
      result
    }

    it 'should be different configs' do
      default_connection = HasOffersV3::Client.new(configuration_to_default_host)
      expect(default_connection.base_uri).to eq('http://api.hasoffers.com/v3')

      proxy_connection = HasOffersV3::Client.new(config_for_proxy)
      expect(proxy_connection.base_uri).to eq('http://api.applift.com/v3')
    end

  end

end
