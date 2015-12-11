module TransactionsImport
  class Paypal < Base
    HEADERS_MAPPING = {
        name: ' Name',
        transaction_date: 'Date',
        amount_spent: ' Amount',
        currency: ' Currency'
    }

    def initialize_field_values
      { system_type: MoneyTransaction::Paypal }
    end

    def validate_row(row)
      row[' Status'] == 'Completed' && !(row[' Name'][/Wargaming/])
    end

    def flip_required?
      true
    end
  end
end