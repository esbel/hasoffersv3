class HasOffersV3
  class Offer < Base
    class << self
      def find_all(params = {})
        post_request 'findAll', params
      end

      def find_all_by_ids(params = {})
        requires! params, [:ids]
        post_request 'findAllByIds', params
      end

      def find_all_ids_by_advertiser_id(params = {})
        requires! params, [:advertiser_id]
        post_request 'findAllIdsByAdvertiserId', params
      end

      def find_by_id(params = {})
        requires! params, [:id]
        post_request 'findById', params
      end

      def get_groups(params = {})
        requires! params, [:id]
        post_request 'getGroups', params
      end

      def get_approved_affiliate_ids(params = {})
        requires! params, [:id]
        post_request 'getApprovedAffiliateIds', params
      end

      def set_payout(params = {})
        requires! params, [:id, :affiliate_id]
        post_request 'setPayout', params
      end
    end
  end
end
