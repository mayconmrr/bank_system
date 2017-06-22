class Account < ApplicationRecord
  belongs_to :user
  has_one :balance 
  before_create :account_number_gen, :agency_number_gen
  after_create :init_balance 
 
  def account_number_gen
    account = Random.new
    digit = Random.new
    new_count_id = (account.rand(1111..9999)).to_s + "-" + (digit.rand(1..9)).to_s
    self.account_number = new_count_id 
  end
  
  def agency_number_gen
    agency = Random.new 
    new_ag_id = (agency.rand(0001..9999)).to_s 
    self.agency_number = new_ag_id 
  end

  def init_balance
  	balance = Balance.create(:account_id => self.id)
  	balance.save!
  end


end
