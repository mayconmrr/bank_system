# frozen_string_literal: true

class StatementsController < ApplicationController
  before_action :set_account, only: :report

  def report
    @statements = Statement.get_report(@account, statement_params[:date])
  end

  private

  def set_account
    @account = Account.find(statement_params[:account_id])
  end

  def statement_params
    params.permit(:balance, :account_id, date: [:begin , :end])
  end
end
