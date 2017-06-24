class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy] 
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_account, only: [:show, :edit, :update]
 
  # GET /accounts/1
  # GET /accounts/1.json
  def show  
    @account = Account.find(params[:id])  
  end 

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end
  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deposit
    account = Account.find(params[:id])
    return head :not_found unless account
    if Account.deposit(account, amount)
      redirect_to account_path(current_user)
      flash[:success] = 'Depósito efetuado com sucesso!'
    else 
      flash[:danger] = 'Valor digitado não é válido. Depósito negado.'
      redirect_to account_path(current_user)
    end  
  end

  def withdraw
    account = Account.find(params[:id])
    return head :not_found unless account 
    if Account.withdraw(account, amount)
      redirect_to account_path(current_user)
      flash[:success] = 'Saque efetuado com sucesso'
    else
      flash[:danger] = 'Saldo insuficiente para a operação.'
      redirect_to account_path(current_user)
    end
  end
  

  def transfer
    account = Account.find(params[:id])
    return head :not_found unless account

    recipient_param = params.permit(:recipient_id)
    recipient = Account.find_by_id(recipient_param[:recipient_id]) 
    
    if recipient.nil?
      puts "entrou"
      flash[:danger] = 'Não foi possível localizar a conta informada. Favor reveja os dados informados'
      redirect_to account_path(current_user)
    else 
      if Account.transfer(account, recipient, amount)
        redirect_to account_path(current_user) 
        flash[:success] = 'Transferência efetuada com sucesso'
      else
        flash[:danger] = 'Saldo insuficiente para a operação.'
        redirect_to account_path(current_user) 
      end
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:agency_number, :account_number, :status, :user_id)
    end

    def amount
      param = params.permit(:amount)
      param[:amount].to_f
    end

    def correct_account
      @account = Account.find(params[:id])
      redirect_to(root_url) unless current_user?(@account.user)
    end

end
