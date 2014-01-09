require 'spec_helper'

describe HasOffersV3::Base do
  subject { HasOffersV3::Base }

  let(:url)  { Regexp.new api_url('Base') }

  describe :requires! do
    it 'raise ArgumentError is parameters are missing' do
      expect { subject.requires!({}, [:dummy]) }.to raise_error(ArgumentError)
    end
  end

  describe ".get_request" do
    it "should make a proper request" do
      stub_call :get
      response = subject.get_request 'test'
      a_request(:get, url).with(query: hash_including({'Method' => 'test'})).should have_been_made
      validate_call response
    end

    context "with HTTPS enabled" do
      before(:each) do
        HasOffersV3.configuration.protocol = 'https'
      end

      it "should make a proper request" do
        stub_call :get
        response = subject.get_request 'test'
        a_request(:get, url).with(query: hash_including({'Method' => 'test'})).should have_been_made
        validate_call response
      end
    end
  end
end
