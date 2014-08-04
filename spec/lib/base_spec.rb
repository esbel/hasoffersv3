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

  describe ".rate_limited" do
    before(:each) do
      HasOffersV3::Base.stub(:sleep) { |seconds| Timecop.freeze(Time.now + seconds) }
    end

    context 'rate limiting is not configured' do
      before(:each) do
        HasOffersV3.configuration.rate_limit = nil
        if HasOffersV3::Base.instance_variable_defined?(:@last_request_at)
          HasOffersV3::Base.send(:remove_instance_variable, :@last_request_at)
        end
        Timecop.freeze
      end

      it 'executes the block without delay' do
        current_time = Time.now
        HasOffersV3::Base.send(:rate_limited) do
          expect(Time.now).to eq(current_time)
        end
      end
    end

    context 'rate limiting is set to 2 reqs / 10 seconds' do
      before(:each) do
        HasOffersV3.configuration.rate_limit = 2.0/10.0
        if HasOffersV3::Base.instance_variable_defined?(:@last_request_at)
          HasOffersV3::Base.send(:remove_instance_variable, :@last_request_at)
        end
        Timecop.freeze
      end

      context 'two requests are started immediately after each other' do
        it 'delays the second request appropriately' do
          current_time = Time.now
          HasOffersV3::Base.send(:rate_limited) do
            expect(Time.now).to eq(current_time)
          end
          HasOffersV3::Base.send(:rate_limited) do
            expect(Time.now).to eq(current_time + 5)
          end
        end
      end

      context 'the second request is started 2 seconds after the first one' do
        it 'delays the second request appropriately' do
          current_time = Time.now
          HasOffersV3::Base.send(:rate_limited) do
            expect(Time.now).to eq(current_time)
          end
          Timecop.freeze(Time.now + 2)
          HasOffersV3::Base.send(:rate_limited) do
            expect(Time.now).to eq(current_time + 5)
          end
        end
      end

      context 'the second request is started 6 seconds after the first one' do
        it 'does not delay the second request' do
          current_time = Time.now
          HasOffersV3::Base.send(:rate_limited) do
            expect(Time.now).to eq(current_time)
          end
          Timecop.freeze(Time.now + 6)
          HasOffersV3::Base.send(:rate_limited) do
            expect(Time.now).to eq(current_time + 6)
          end
        end
      end

      after(:each) do
        HasOffersV3.configuration.rate_limit = nil
      end
    end
  end
end
