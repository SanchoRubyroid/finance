module Admin::HomeHelper
  def years
    @years ||= (MoneyTransaction.minimum(:transaction_date).year..MoneyTransaction.maximum(:transaction_date).year)
  end
end
