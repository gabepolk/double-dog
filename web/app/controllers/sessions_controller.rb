class SessionsController < ApplicationController
  def new
  end

  def create
    result = DoubleDog::SignIn.run(sessions_params)
    #success(:user => retrieved_user, :session_id => session_id)
    if result[:success?]
      session[:session_id] = result[:session_id]
    else
      redirect_to :back
    end
  end

  def destroy
    session[:session_id] = nil
  end

  private
  def sessions_params
    params.permit(:username, :password)
  end
end
