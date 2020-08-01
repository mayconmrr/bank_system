# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy deposit withdraw close_account transfer]
  before_action :logged_in_user, except: %i[new create]
  before_action :find_recipient, only: :transfer

  def show
    @account = Account.find(params[:id])
    @statement = @account.statements
  end

  def new
    @account = Account.new
  end

  def edit; end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  def deposit
    if @account.deposit(amount)
      flash[:success] = 'Depósito efetuado com sucesso!'
    else
      flash[:danger] = 'Valor digitado não é válido. Depósito negado.'
    end
    redirect_to account_path(current_user)
  end

  def withdraw
    if @account.withdraw(amount)
      flash[:success] = 'Saque efetuado com sucesso'
    else
      flash[:danger] = 'Saldo insuficiente para a operação.'
    end
    redirect_to account_path(current_user)
  end

  def transfer
    if @account.transfer(@recipient.id, amount)
      flash[:success] = 'Transferência efetuada com sucesso'
    else
      flash[:danger] = 'Saldo insuficiente para a operação.'
    end

    redirect_to account_path(current_user)
  end

  def close_account
    @account.close_account
    redirect_to account_path(current_user)
    flash[:success] = 'Sua conta foi desativada com sucesso!'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:agency_number, :account_number, :status, :user_id)
  end

  def amount
    param = params.permit(:amount)
    param[:amount].to_f
  end

  def find_recipient
    @recipient = Account.find(params[:recipient_id])
    if @recipient.nil?
      redirect_to account_path(current_user)
      flash[:danger] = 'Não foi possível localizar a conta informada. Favor reveja os dados informados'
    end
  end
end
