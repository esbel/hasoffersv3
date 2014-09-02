class HasOffersV3
  class Conversion < Base
    class << self
      def findAll(params = {})
        deprecation 'findAll', 'find_all'
        find_all params
      end

      def find_all(params = {})
        get_request 'findAll', params
      end

      def find_added_conversions(params = {})
        get_request 'findAddedConversions', params
      end

      def find_updated_conversions(params = {})
        get_request 'findUpdatedConversions', params
      end
    end
  end
end
