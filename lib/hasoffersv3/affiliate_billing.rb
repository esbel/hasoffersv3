class HasOffersV3
  class AffiliateBilling < Base
    class << self
      def find_last_invoice(params = {})
        requires! params, [:affiliate_id]
        post_request 'findLastInvoice', params
      end

      def create_invoice(params = {})
        requires! params, [:data]
        post_request 'createInvoice', params
      end

      def find_invoice_by_id(params = {})
        requires! params, [:id]
        post_request 'findInvoiceById', params
      end

      def add_invoice_item(params = {})
        requires! params, [:affiliate_id, :data]
        post_request 'addInvoiceItem', params
      end

      def remove_invoice_item(params = {})
        requires! params, [:id]
        post_request 'removeInvoiceItem', params
      end
    end
  end
end
