class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)
    if user&.authenticate(params.dig(:session, :password))
      # Log the user in and redirect to the user's show page.
      reset_session
      log_in user
      redirect_to user, status: :see_other
    else
      flash.now[:danger] = t "controller.sessions_c.invalid"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path, status: :see_other
  end
end
