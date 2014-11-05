require 'spec_helper'

describe HasOffersV3::AffiliateBilling do
  subject { HasOffersV3::AffiliateBilling }

  let(:url) { api_url 'AffiliateBilling' }

  describe '.find_last_invoice' do
    context 'when affiliate ID is specified' do
      it 'makes a proper request call' do
        stub_call
        response = subject.find_last_invoice(affiliate_id: '1')
        a_request(:post, url).with(body: hash_including({'Method' => 'findLastInvoice', 'affiliate_id' => '1'})).should have_been_made
        validate_call response
      end
    end

    context 'when affiliate ID is missing' do
      it 'raises an exception' do
        expect { subject.find_last_invoice }.to raise_error ArgumentError
      end
    end
  end

  describe '.create_invoice' do
    context 'when data is specified' do
      it 'makes a proper request call' do
        stub_call
        response = subject.create_invoice(data: {affiliate_id: 1, start_date: '2014-10-01', end_date: '2014-10-30'})
        a_request(:post, url).with(body: hash_including({
          'Method' => 'createInvoice',
          'data'   => {'affiliate_id' => '1', 'start_date' => '2014-10-01', 'end_date' => '2014-10-30'}
        })).should have_been_made
        validate_call response
      end
    end

    context 'when data is not specified' do
      it 'raises an exception' do
        expect { subject.create_invoice }.to raise_error ArgumentError
      end
    end
  end

  describe '.find_invoice_by_id' do
    context 'when ID is specified' do
      it 'makes a proper request call' do
        stub_call
        response = subject.find_invoice_by_id(id: '1')
        a_request(:post, url).with(body: hash_including({'Method' => 'findInvoiceById', 'id' => '1'})).should have_been_made
        validate_call response
      end
    end

    context 'when ID is missing' do
      it 'raises an exception' do
        expect { subject.find_invoice_by_id }.to raise_error ArgumentError
      end
    end
  end

  describe '.add_invoice_item' do
    context 'when affiliate ID and data is specified' do
      it 'makes a proper request call' do
        stub_call
        response = subject.add_invoice_item(affiliate_id: 1, data: {memo: 'abc'})
        a_request(:post, url).with(body: hash_including({
          'Method'       => 'addInvoiceItem',
          'affiliate_id' => '1',
          'data'         => {'memo' => 'abc'}
        })).should have_been_made
        validate_call response
      end
    end

    context 'when affiliate ID is not specified' do
      it 'raises an exception' do
        expect { subject.add_invoice_item(data: {memo: 'abc'}) }.to raise_error ArgumentError
      end
    end

    context 'when data is not specified' do
      it 'raises an exception' do
        expect { subject.add_invoice_item(affiliate_id: 1) }.to raise_error ArgumentError
      end
    end
  end

  describe '.remove_invoice_item' do
    context 'when ID is specified' do
      it 'makes a proper request call' do
        stub_call
        response = subject.remove_invoice_item(id: '1')
        a_request(:post, url).with(body: hash_including({'Method' => 'removeInvoiceItem', 'id' => '1'})).should have_been_made
        validate_call response
      end
    end

    context 'when ID is missing' do
      it 'raises an exception' do
        expect { subject.remove_invoice_item }.to raise_error ArgumentError
      end
    end
  end
end
