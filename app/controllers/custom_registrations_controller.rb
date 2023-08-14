# app/controllers/custom_registrations_controller.rb
class CustomRegistrationsController < Devise::RegistrationsController
  def create
    begin
      super
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages.join(', ') }, status: :unprocessable_entity
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  # Add any additional fields you want to permit during registration
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :city, :country)
  end
end
