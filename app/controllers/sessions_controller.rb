class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)
    if user&.authenticate(params.dig(:session, :password))
      # reset_session
      log_in user
      if params.dig(:session,
                    :remember_me) == "1"
        remember(user)
      else
        forget(user)
      end
      redirect_back_or user
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
