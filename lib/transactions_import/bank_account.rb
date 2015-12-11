module TransactionsImport
  class BankAccount < Base
    HEADERS_MAPPING = {
        name: 'Description',
        transaction_date: 'Date',
        amount_spent: 'Debit'
    }

    def initialize_field_values
      { system_type: MoneyTransaction::BankAccount, currency: 'USD' }
    end

    def flip_required?
      true
    end

    def validate_row(row)
      !(row['Description'][/AUTOMATIC WITHDRAWAL.*PAYPAL/] ||
        row['Description'][/CO-OP NETWORK ATM/] ||
        row['Description'][/ONLINE BANKING FUNDS TRANSFER/])
    end
  end
end