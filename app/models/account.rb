class Account < ApplicationRecord
  belongs_to :user 
  has_many :statements
  before_create :account_number_gen, :agency_number_gen
  after_save :statement_register
 
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
    tax = self.rate(amount)  
    ActiveRecord::Base.transaction do
      if self.withdraw(account, (amount + tax))
        self.deposit(recipient, amount)
      end
    end
  end
 
  def self.close_account(account)
    account.status = 1
    account.save!
  end  

  def statement_register
    statement = Statement.create(:account_id => self.id, :balance => self.balance) 
    statement.save!
  end

  private

  def self.amount_valid?(amount)
    if amount <= 0
      puts 'Depósito deve ser maior que 0.'
      return false
    end
    return true
  end 

  def self.rate(amount) 
    if (Time.now.hour > 9 && Time.now.hour < 18) && 
       (Date.today.strftime("%A") != 'Saturday' && Date.today.strftime("%A") != 'Sunday') 
      tax = 5.0
      if amount > 1000
        tax = tax + 10.0
      end
      return tax 
    else
      puts "entrou no else" 
      tax = 7.0
      if amount > 100
        tax = tax + 10.0 
      end
      return tax
    end 
    return tax
  end   

end



