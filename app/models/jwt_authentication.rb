# frozen_string_literal: true

class JwtAuthentication < ApplicationRecord
  def self.registered?(key, secret)
    where(key: key, secret: secret).count > 0
  end
end
