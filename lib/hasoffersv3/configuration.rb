class HasOffersV3
  class Configuration

    DEFAULTS = {
      host: 'api.hasoffers.com',
      protocol: 'http',
      base_path: '/v3',
      network_id: '',
      api_key: '',
      proxy_url: ''
    }

    DEFAULTS.keys.each do |option_name|
      define_method option_name do
        @options[option_name]
      end

      define_method "#{option_name}=" do |val|
        @options[option_name] = val
      end
    end

    attr_reader :options

    def initialize(options={})
      defaults = DEFAULTS.dup
      @options = options.dup


      defaults.keys.each do |key|
        # Symbolize only keys that are needed
        @options[key] = @options[key.to_s] if @options.has_key?(key.to_s)
      end

      # Use default when option is not specified or nil
      defaults.keys.each do |key|
        @options[key] = defaults[key] if @options[key].nil?
      end
    end

    def base_uri
      "#{protocol}://#{host}#{base_path}"
    end
  end
end
