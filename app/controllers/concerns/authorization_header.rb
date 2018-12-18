module Concerns::AuthorizationHeader
  extend ActiveSupport::Concern

  def authorization_header_not_found
    render json: {error: __method__}, status: :unauthorized
  end

  def invalid_authorization_header
    render json: {error: __method__}, status: :unauthorized
  end

  def check_authorization_header
    return authorization_header_not_found unless has_authorization_header?
    invalid_authorization_header unless has_valid_authorization_header?
  end

  def has_authorization_header?
    authorization_header.to_s.present? && !authorization_header.to_s.start_with?('Basic')
  end

  def has_valid_authorization_header?
    Client.exists?(access_token: authorization_header)
  end

  def authorization_header
    request.headers[:Authorization]
  end
end