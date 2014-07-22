class SessionsController < ApplicationController
  def new
  end

  def create
    # Call transaction script with params
    result = DoubleDog::SignIn.run(sessions_params)
    #success(:user => retrieved_user, :session_id => session_id)
    if result.success?
      session[:session_id] = result[:session_id]
    else
      # error handling
      redirect_to signin_path
    end
  end

  def destroy
    # DoubleDog::SignOut.run(session[:session_id])
    session[:session_id] = nil
  end

  private
  def sessions_params
    params.permit(:username, :password)
  end
end