class SessionsController < ApplicationController
  include Concerns::SignatureHeader

  before_action :check_signature_header
  before_action :check_user
  before_action :check_password
  before_action :check_access_token

  def sign_in
    render json: @user, access_token: @client.access_token
  end

  private

  def check_user
    @user = User.find_for_database_authentication(email: params[:email], name: params[:name])
    user_not_found unless @user
  end

  def check_password
    invalid_password unless @user.authenticate(params[:password])
  end

  def check_access_token
    @client = @user.clients.active.first
    access_token_not_found unless @client
  end

  def user_not_found
    render json: {error: __method__}, status: :not_found
  end

  def invalid_password
    render json: {error: __method__}, status: :bad_request
  end

  def access_token_not_found
    render json: {error: __method__}, status: :not_found
  end
end
