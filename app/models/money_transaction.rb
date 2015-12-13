class MoneyTransaction < ActiveRecord::Base
  has_paper_trail

  BankAccount = 'bank_account'.freeze
  Paypal = 'paypal'.freeze

  SYSTEM_TYPES = [
      BankAccount,
      Paypal
  ]

  validates :name, :transaction_date, :system_type, :amount_spent, presence: true
  validates :amount_spent, numericality: { greater_than: 0 }
  validates :amount_spent_olya, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  default_scope { order('transaction_date desc') }

  scope :for_month, -> (date = Date.today) {
    where(transaction_date: date.beginning_of_month..date.end_of_month)
  }

  scope :total, -> (date_or_range = nil) {
    relation = self
    relation = relation.where(transaction_date: date_or_range.beginning_of_month..date_or_range.end_of_month) if date_or_range.is_a?(Date)
    relation = relation.where(transaction_date: date_or_range) if date_or_range.is_a?(Range)
    relation.sum(:amount_spent_olya)
  }

  def flip_amount_spent
    self.amount_spent = (self.amount_spent.to_f * -1)
  end
end
