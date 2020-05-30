# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one :account

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  after_create :init_account

  GENDER_TYPES = %w[Masculino Feminino].freeze

  private

  def init_account
    Account.create(user: self)
  end
end
