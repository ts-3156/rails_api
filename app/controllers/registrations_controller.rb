class RegistrationsController < ApplicationController
  include Concerns::SignatureHeader

  before_action :check_signature_header

  def sign_up
    user, access_token = User.create_with_access_token!(email: params[:email], name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation], app: current_app)
    render json: user, access_token: access_token
  end
end
