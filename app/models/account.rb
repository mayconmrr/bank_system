# frozen_string_literal: true

class Account < ApplicationRecord
  WEEK_BUSSINES_TAX = 5.0
  LIMIT_AMOUNT_TAX = 10.0
  WEEKEND_AND_EXTRA_HOURS_TAX = 7.0

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

  def withdraw(amount)
    return false unless amount_valid?(amount)

    self.balance = (self.balance -= amount).round(2)
    self.balance.positive? ? self.save! : false
  end

  def transfer(recipient, amount)
    return false unless amount_valid?(amount)

    tax = rate(amount)
    ActiveRecord::Base.transaction do
      deposit(recipient, amount) if withdraw(self, (amount + tax))
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
    amount.positive?
  end

  def self.rate(amount)
    tax = normal_business_hours? ? WEEK_BUSSINES_TAX : WEEKEND_AND_EXTRA_HOURS_TAX
    tax += LIMIT_AMOUNT_TAX if amount > 1000
    tax
  end

  private

  def normal_business_hours?
    business_hours? && week_days?
  end

  def business_hours?
    Time.now.hour > 9 && Time.now.hour < 18
  end

  def week_days?
    Date.today.strftime('%A') != 'Saturday' && Date.today.strftime('%A') != 'Sunday'
  end
end
