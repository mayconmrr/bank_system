class User < ApplicationRecord
	has_one :account
	before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  after_create :init_account
  
  GENDER_TYPES = ["Masculino", "Feminino"]

  def init_account
    account = Account.create(:user_id => self.id)
    account.save!
  end

end
