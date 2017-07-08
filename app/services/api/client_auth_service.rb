require 'digest/md5'

module Api
  class ClientAuthService < ::BaseService

    TEMP_SECRET_KEY = Rails.configuration.x.api_client_key || 'estherilake'
    TS_EXPIRED_INTERVAL = 30.minutes

    validate :timestamp_expired
    validate :checksum_match

    def initialize(checksum, timestamp)
      @checksum = checksum
      @timestamp = timestamp
    end

    def run
      valid?
    end

    private

    def md5(str)
      Digest::MD5.hexdigest(str)
    end

    def checksum_match
      str = "#{TEMP_SECRET_KEY}-#{@timestamp}"
      errors.add(:checksum, 'is not matched') unless md5(str) == @checksum
    end

    def timestamp_expired
      unless (TS_EXPIRED_INTERVAL.ago.to_i..(Time.zone.now + 5.minutes).to_i).cover?(@timestamp.to_i)
        errors.add(:timestamp, "must within #{(TS_EXPIRED_INTERVAL / 1.minute).to_i} minutes")
      end
    end

  end
end
