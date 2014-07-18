module DoubleDog
  class CreateAccount < DoubleDog::Script

    def run(params)
      return failure(:not_admin) unless admin_session?(params[:session_id])
      return failure(:invalid_username) unless valid_attribute?(params[:username], 3)
      return failure(:invalid_password) unless valid_attribute?(params[:password], 3)

      user = DoubleDog.db.create_user(:username => params[:username], :password => params[:password])
      return success(:user => user)
    end

  end
end
