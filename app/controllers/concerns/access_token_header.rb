module Concerns::AccessTokenHeader
  extend ActiveSupport::Concern

  def access_token_header_not_found
    render json: {error: __method__}, status: :bad_request
  end

  def invalid_access_token_header
    render json: {error: __method__}, status: :bad_request
  end

  def check_access_token_header
    if !has_access_token_header?
      access_token_header_not_found
    elsif !has_valid_access_token_header?
      invalid_access_token_header
    end
  end

  def has_access_token_header?
    !access_token_header.to_s.empty?
  end

  def has_valid_access_token_header?
    Client.exists?(access_token: access_token_header)
  end

  def access_token_header
    request.headers['X-ACCESS-TOKEN']
  end
end