# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :account

  def self.get_report(account, date = {})
    account.statements.where('created_at >= ? and created_at <= ?', date['begin'], date['end']).reverse
  end
end
