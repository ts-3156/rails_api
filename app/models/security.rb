require 'openssl'

class Security
  class << self
    def sign(secret, nonce, url)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, "#{nonce}#{url}")
    end

    def verify?(token, nonce, signature, url)
      client = Client.find_by(access_token: token)
      client && sign(client.access_secret, nonce, url) == signature
    end
  end
end