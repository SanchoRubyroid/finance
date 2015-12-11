class FinanceController < ApplicationController
  before_action :authenticate_user!

  DATES_BEFORE_COUNT = 2

  def index
    if request.post?
      if params[:money_transactions].is_a?(Hash)
        MoneyTransaction.where(id: params[:money_transactions].keys).each do |money_transaction|
          value = params[:money_transactions][money_transaction.id.to_s]
          value = (value.blank? ? nil : value.to_f)

          money_transaction.update_attribute(:amount_spent_olya, value)
        end

        flash[:notice] = 'Transactions were successfully updated.'
      end
    else
      flash[:notice] = nil
    end

    dates = []
    target_date = (params[:month].to_i.between?(1,12) ? Date.new(Date.today.year, params[:month].to_i, 1) : Date.today )

    DATES_BEFORE_COUNT.downto(1) { |index| dates << target_date - index.month }

    dates << target_date

    @dates_range = dates.first.beginning_of_month..dates.last.end_of_month

    @transactions = dates.inject([]) do |transactions, date|
      transactions << { month_year_caption: date.strftime("%B %Y"),
                        transactions: MoneyTransaction.for_month(date) }
    end
  end
end
