# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :logged_in_user, except: %i[new create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Cadastro efetuado com sucesso. Seja bem-vindo!'
      log_in @user
      redirect_back_or @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Dados atualizados com sucesso!'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :gender, :password, :password_confirmation)
  end
end
