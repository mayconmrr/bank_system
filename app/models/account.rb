class Account < ApplicationRecord
  belongs_to :user 
  before_create :account_number_gen, :agency_number_gen 
 
  def account_number_gen
    account = Random.new
    digit = Random.new
    new_count_id = (account.rand(1111..99999)).to_s + "-" + (digit.rand(1..9)).to_s
    self.account_number = new_count_id 
  end
  
  def agency_number_gen
    agency = Random.new 
    new_ag_id = (agency.rand(0001..9999)).to_s 
    self.agency_number = new_ag_id 
  end 

  def self.deposit(account, amount)
    puts "Depositing #{amount} on account #{account.id}"
    return false unless self.amount_valid?(amount)
    account.balance = (account.balance += amount).round(2)
    account.save!
  end

  def self.withdraw(account, amount)
    puts "Withdrawing #{amount} on account #{account.id}"
    return false unless self.amount_valid?(amount)
    #return false unless self.balance_valid?(amount)
    account.balance = (account.balance -= amount).round(2)
    if account.balance > 0
      account.save!
    else
      puts "Saldo insuficiente"
      return false
    end
  end

  def self.transfer(account, recipient, amount)
    puts "Transfering #{amount} from account #{account.id} to account #{recipient.id}"
    return false unless self.amount_valid?(amount)
    ActiveRecord::Base.transaction do
      if self.withdraw(account, amount)
        self.deposit(recipient, amount)
      end
    end
  end

  def self.close_account(account)
    account.status = 1
    account.save!
  end


  private

  def self.amount_valid?(amount)
    if amount <= 0
      puts 'Depósito deve ser maior que 0.'
      return false
    end
    return true
  end 

end
