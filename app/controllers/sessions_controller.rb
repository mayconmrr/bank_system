# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_back_or user
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
