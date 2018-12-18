require 'openssl'

class Security
  class << self
    def sign(secret, nonce, url)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, "#{nonce}#{url}")
    end

    def verify?(client_id, nonce, signature, url)
      app = App.find_by(client_id: client_id)
      app && sign(app.client_secret, nonce, url) == signature
    end
  end
end