module Concerns::SignatureHeader
  extend ActiveSupport::Concern

  include Concerns::NonceHeader
  include Concerns::ClientIdHeader

  def signature_header_not_found
    render json: {error: __method__}, status: :bad_request
  end

  def invalid_signature_header
    render json: {error: __method__}, status: :bad_request
  end

  def check_signature_header
    check_nonce_header
    return if performed?

    check_client_id_header
    return if performed?

    if !has_signature_header?
      signature_header_not_found
    elsif !has_valid_signature_header?(client_id_header, nonce_header, request.path_info)
      invalid_signature_header
    end
  end

  def has_signature_header?
    !signature_header.to_s.empty?
  end

  def has_valid_signature_header?(client_id, nonce, path)
    Security.verify?(client_id, nonce, signature_header, path)
  end

  def signature_header
    request.headers['X-Signature']
  end

  def current_app
    @app ||= App.find_by(client_id: client_id_header)
  end
end