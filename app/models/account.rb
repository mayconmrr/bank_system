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

  private
  def self.amount_valid?(amount)
    if amount <= 0
      puts 'Transaction failed! Amount must be greater than 0.00'
      return false
    end
    return true
  end
end
