require 'spec_helper'

describe HasOffersV3::Adapter do

  let(:configuration) { HasOffersV3::Configuration.new(host: 'example.com') }
  subject { HasOffersV3::Adapter.new(HasOffersV3::Offer, HasOffersV3::Offer) }

  describe '#with_configuration' do
    it 'should apply for block another config' do
      default_config = HasOffersV3.configuration
      expect(HasOffersV3::Offer.client.configuration).to eq(default_config)

      subject.with_configuration do
        expect(HasOffersV3::Offer.client.configuration).to eq(subject.configuration)
      end

    end
  end

end
