class MoneyTransaction < ActiveRecord::Base

  BankAccount = 'bank_account'.freeze
  Paypal = 'paypal'.freeze

  SYSTEM_TYPES = [
      BankAccount,
      Paypal
  ]

  validates :name, :transaction_date, :system_type, :amount_spent, presence: true
  validates :amount_spent, numericality: { greater_than: 0 }
  validates :amount_spent_olya, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  def flip_amount_spent
    self.amount_spent = (self.amount_spent.to_f * -1)
  end
end
