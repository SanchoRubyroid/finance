class FinanceController < ApplicationController
  before_action :authenticate_user!

  DATES_BEFORE_COUNT = 2

  def index
    dates = []
    target_date = Date.today

    DATES_BEFORE_COUNT.downto(1) { |index| dates << target_date - index.month }

    dates << target_date

    @transactions = dates.inject([]) do |transactions, date|
      transactions << { month_year_caption: date.strftime("%B %Y"),
                        transactions: MoneyTransaction.for_month(date) }
    end
  end
end
