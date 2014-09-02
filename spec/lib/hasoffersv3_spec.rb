require 'spec_helper'

describe HasOffersV3 do

  context 'singleton' do
    it 'should use default config' do
      subject = HasOffersV3::Offer.client.configuration
      expect(subject).to eq(HasOffersV3.configuration)
    end
  end

  describe '#configuration' do
    it 'should create different connections' do
      subject = HasOffersV3.new
      expect(subject.configuration).to_not eq(HasOffersV3.configuration)
    end
  end

  context 'api' do
    subject { HasOffersV3.new }

    describe '#offers' do
      it 'should get offers for current connection' do
        expect(HasOffersV3::Offer).to receive(:find_all)
        subject.offers.find_all
      end
    end
  end
end

