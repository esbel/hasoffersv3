class HasOffersV3
  class AdvertiserBilling < Base
    class << self
      def find_all_invoices(params = {})
        post_request 'findAllInvoices', params
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
        requires! params, [:invoice_id, :data]
        post_request 'addInvoiceItem', params
      end

      def remove_invoice_item(params = {})
        requires! params, [:id]
        post_request 'removeInvoiceItem', params
      end
    end
  end
end
