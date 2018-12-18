class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token

  protected

  rescue_from Exception, with: :something_error

  def something_error(ex)
    unless performed?
      status = ex.class == ActiveRecord::RecordInvalid ? :unprocessable_entity : :internal_server_error
      respond_to do |type|
        type.json {render json: {error: ex.class.to_s, error_message: ex.message}, status: status}
        type.all {render plain: "#{ex.class}: #{ex.message}", status: status}
      end
    end
  end
end
