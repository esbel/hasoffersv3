module HasOffersV3
  class RawLog < Base
    class << self
      def get_download_link(params = {})
        requires! params, [:log_type, :log_filename]
        get_request 'getDownloadLink', params
      end

      def get_log_expirations
        get_request 'getLogExpirations'
      end

      def list_date_dirs(params = {})
        requires! params, [:log_type]
        get_request 'listDateDirs', params
      end

      def list_logs(params = {})
        requires! params, [:log_type, :date_dir]
        get_request 'listLogs', params
      end
    end
  end
end
