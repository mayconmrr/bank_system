# frozen_string_literal: true

class Transfer < BaseService
  def initialize(sender, recipient, amount)
    @sender = sender
    @recipient = recipient
    @amount = amount
  end

  def call
    rate = Account.rate(@amount)
    execute_transfer!(rate + @amount)
  end

  private

  def execute_transfer!(total_amount)
    ActiveRecord::Base.transaction do
      @sender.withdraw(total_amount)
      @recipient.deposit(@amount)
    end
  end
end
