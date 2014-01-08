require 'spec_helper'

describe HasOffersV3::RawLog do
  subject { HasOffersV3::RawLog }

  let(:url)  { Regexp.new api_url('RawLog') }

  before :each do
    stub_call :get
  end

  describe '.get_download_link' do
    it 'should make a proper request call' do
      response = subject.get_download_link log_type: 'clicks', log_filename: 'xxx'
      a_request(:get, url).with(query: hash_including({'Method' => 'getDownloadLink'})).should have_been_made
      validate_call response
    end

    context 'when there is no log_type' do
      it 'it should raise an exception' do
        expect { subject.get_download_link log_filename: 'xxx' }.to raise_error ArgumentError
      end
    end

    context 'when there is no log_filename' do
      it 'it should raise an exception' do
        expect { subject.get_download_link log_type: 'clicks' }.to raise_error ArgumentError
      end
    end
  end

  describe '.get_log_expirations' do
    it 'should make a proper request call' do
      response = subject.get_log_expirations
      a_request(:get, url).with(query: hash_including({'Method' => 'getLogExpirations'})).should have_been_made
      validate_call response
    end
  end

  describe '.list_date_dirs' do
    it 'should make a proper request call' do
      response = subject.list_date_dirs log_type: 'clicks'
      a_request(:get, url).with(query: hash_including({'Method' => 'listDateDirs'})).should have_been_made
      validate_call response
    end

    context 'when there is no log_type' do
      it 'it should raise an exception' do
        expect { subject.list_date_dirs }.to raise_error ArgumentError
      end
    end
  end

  describe '.list_logs' do
    it 'should make a proper request call' do
      response = subject.list_logs log_type: 'clicks', date_dir: '20140101'
      a_request(:get, url).with(query: hash_including({'Method' => 'listLogs'})).should have_been_made
      validate_call response
    end

    context 'when there is no log_type' do
      it 'it should raise an exception' do
        expect { subject.list_logs date_dir: '20140101' }.to raise_error ArgumentError
      end
    end

    context 'when there is no date_dir' do
      it 'it should raise an exception' do
        expect { subject.list_logs log_type: 'clicks' }.to raise_error ArgumentError
      end
    end
  end
end