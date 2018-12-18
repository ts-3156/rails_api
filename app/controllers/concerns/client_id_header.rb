module Concerns::ClientIdHeader
  extend ActiveSupport::Concern

  def client_id_header_not_found
    render json: {error: __method__}, status: :bad_request
  end

  def invalid_client_id_header
    render json: {error: __method__}, status: :bad_request
  end

  def check_client_id_header
    if !has_client_id_header?
      client_id_header_not_found
    elsif !has_valid_client_id_header?
      invalid_client_id_header
    end
  end

  def has_client_id_header?
    !client_id_header.to_s.empty?
  end

  def has_valid_client_id_header?
    App.exists?(client_id: client_id_header)
  end

  def client_id_header
    request.headers['X-Client-Id']
  end
end