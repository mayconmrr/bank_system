# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'Por favor, faça o login.'
    redirect_to login_url
  end
end
