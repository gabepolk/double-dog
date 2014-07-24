class UsersController < ApplicationController
  def new
  end

  def create
    result = DoubleDog::CreateAccount.run(params)
    if result[:success?]
      redirect_to('/')
    else
      redirect_to('/signup')
    end
  end
end
