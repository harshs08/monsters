class SessionsController < ApplicationController
  
  def create
    begin
      # render text: request.env['omniauth.auth'].to_yml
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success]   = "Welcome, #{@user.name}!"
      redirect_to user_path(@user)
    rescue
      flash[:warning]   = "There was an error trying to authenticate you..."
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = "See you!"
    end
    redirect_to root_path
  end

end
