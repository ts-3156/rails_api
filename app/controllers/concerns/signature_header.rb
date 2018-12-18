module Concerns::SignatureHeader
  extend ActiveSupport::Concern

  include Concerns::NonceHeader
  include Concerns::AccessTokenHeader

  def signature_header_not_found
    render json: {error: __method__}, status: :bad_request
  end

  def invalid_signature_header
    render json: {error: __method__}, status: :bad_request
  end

  def check_signature_header
    check_nonce_header
    return if performed?

    check_access_token_header
    return if performed?

    if !has_signature_header?
      signature_header_not_found
    elsif !has_valid_signature_header?(access_token_header, nonce_header, request.path_info)
      invalid_signature_header
    end
  end

  def has_signature_header?
    !signature_header.to_s.empty?
  end

  def has_valid_signature_header?(access_token, nonce, path)
    Security.verify?(access_token, nonce, signature_header, path)
  end

  def signature_header
    request.headers['X-SIGNATURE']
  end
end