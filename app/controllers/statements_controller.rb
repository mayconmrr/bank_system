# frozen_string_literal: true

class StatementsController < ApplicationController
  before_action :set_statement, only: %i[show edit update destroy]

  def report
    @statements = Statement.get_report(statement_params[:date])
  end

  private

  def set_statement
    @statement = Statement.find(params[:id])
  end

  def statement_params
    params.require(:statement).permit(:balance, :account_id, :date)
  end
end
