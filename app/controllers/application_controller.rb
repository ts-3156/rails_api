class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token

  protected

  rescue_from Exception, with: :something_error

  def something_error(ex)
    unless performed?
      respond_to do |type|
        type.json {render json: {error: ex.class, error_message: ex.message}, status: :internal_server_error}
        type.all {render plain: "#{ex.class}: #{ex.message}", status: :internal_server_error}
      end
    end
  end
end
