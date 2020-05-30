# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  has_many :statements
  before_create :account_number_gen, :agency_number_gen
  before_save :statement_register

  def account_number_gen
    account = Random.new
    digit = Random.new
    new_count_id = account.rand(1111..99_999).to_s + '-' + digit.rand(1..9).to_s
    self.account_number = new_count_id
  end

  def agency_number_gen
    agency = Random.new
    new_ag_id = agency.rand(0o001..9999).to_s
    self.agency_number = new_ag_id
  end

  def self.deposit(account, amount)
    return false unless amount_valid?(amount)

    account.balance = (account.balance += amount).round(2)
    account.save!
  end

  def self.withdraw(account, amount)
    return false unless amount_valid?(amount)

    # return false unless self.balance_valid?(amount)
    account.balance = (account.balance -= amount).round(2)
    account.balance > 0 ? account.save! : false
  end

  def self.transfer(account, recipient, amount)
    return false unless amount_valid?(amount)

    tax = rate(amount)
    ActiveRecord::Base.transaction do
      deposit(recipient, amount) if withdraw(account, (amount + tax))
    end
  end

  def self.close_account(account)
    account.status = 1
    account.save!
  end

  def statement_register
    Statement.create(account_id: id, balance: balance)
  end

  def self.amount_valid?(amount)
    if amount <= 0
      return false
    end
    true
  end

  def self.rate(amount)
    if (Time.now.hour > 9 && Time.now.hour < 18) &&
       (Date.today.strftime('%A') != 'Saturday' && Date.today.strftime('%A') != 'Sunday')
      tax = 5.0
      tax += 10.0 if amount > 1000
      return tax
    else
      tax = 7.0
      tax += 10.0 if amount > 100
      return tax
    end
    tax
  end
end
