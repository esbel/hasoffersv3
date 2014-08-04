module HasOffersV3
  class Configuration
    attr_accessor :network_id, :api_key, :protocol, :host, :base_path, :rate_limit

    def initialize
      @protocol   = 'http'
      @host       = 'api.hasoffers.com'
      @base_path  = '/v3'
    end

    def base_uri
      "#{protocol}://#{host}#{base_path}"
    end
  end
end
