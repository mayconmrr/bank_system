class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      puts user
      redirect_to user_path(user.id) 
      flash[:success] = 'Login efetuado com sucesso!'
    else
      flash.now[:danger] = 'Email e/ou senha incorreto, por favor tente novamente.'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'Logout efetuado com sucesso!'
    redirect_to root_url
  end
  
end
