module Concerns::NonceHeader
  extend ActiveSupport::Concern

  def nonce_header_not_found
    render json: {error: __method__}, status: :bad_request
  end

  def invalid_nonce_header
    render json: {error: __method__}, status: :bad_request
  end

  def check_nonce_header
    if !has_nonce_header?
      nonce_header_not_found
    elsif !has_valid_nonce_header?
      invalid_nonce_header
    end
  end

  def has_nonce_header?
    !nonce_header.to_s.empty?
  end

  NONCE_TIMEOUT = 1.minutes

  def has_valid_nonce_header?
    nonce_header.match?(/\A\d+\z/) && nonce_header.to_i > (Time.zone.now - NONCE_TIMEOUT).to_i
  end

  def nonce_header
    request.headers['X-Nonce']
  end

end