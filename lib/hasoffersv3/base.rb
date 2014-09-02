require 'net/http' if RUBY_VERSION < '2'
require 'active_support/core_ext/object/to_query'

class HasOffersV3
  class Base
    class << self
      def get_request(method, params = {}, &block)
        if block.nil?
          make_request(:get, method, params)
        else
          page = 1
          begin
            response = make_request(:get, method, params.merge(page: page))
            block.call response
            page += 1
          end until page > (response.page_info['page_count'] || 1)
        end
      end

      def post_request(method, params = {}, &block)
        if block.nil?
          make_request(:post, method, params)
        else
          page = 1
          begin
            response = make_request(:post, method, params.merge(page: page))
            block.call response
            page += 1
          end until page > (response.page_info['page_count'] || 1)
        end
      end

      def requires!(hash, required_params)
        missing_params = []
        required_params.each do |param|
          missing_params.push param unless hash.has_key?(param)
        end
        unless missing_params.empty?
          raise ArgumentError.new("Missing required parameter(s): #{missing_params.join(', ')}")
        end
      end

      def target
        name.split('::').last
      end

      def client
        HasOffersV3.client
      end

      private

      def deprecation(from, to)
        warn "\033[31m[DEPRECATION] `#{ name }.#{ from }` is deprecated. Please use `#{ name }.#{ to }` instead.\033[0m"
      end

      def make_request(http_method, method, params)
        client.request(http_method, target, method, params)
      end

    end
  end
end
