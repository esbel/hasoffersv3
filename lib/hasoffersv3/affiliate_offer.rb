class HasOffersV3
  class AffiliateOffer < Base

    def self.target
      'Affiliate_Offer'
    end

    def self.find_all(params = {})
      post_request 'findAll', params
    end

    def self.find_by_id(params = {})
      requires! params, [:id]
      post_request 'findById', params
    end

    def self.get_categories(params = {})
      requires! params, [:ids]
      post_request 'getCategories', params
    end

    def self.get_target_countries(params = {})
      requires! params, [:ids]
      post_request 'getTargetCountries', params
    end

    def self.generate_tracking_link(params = {})
      requires! params, [:offer_id]
      post_request 'generateTrackingLink', params
    end

  end
end
