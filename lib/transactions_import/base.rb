require 'csv'

module TransactionsImport
  class Base

    attr_reader :successful_transactions, :new_transactions, :rejected_transactions

    class << self
      def build_import_by_type(transactions_type, transactions_file)
        case transactions_type
          when MoneyTransaction::BankAccount
            TransactionsImport::BankAccount.new(transactions_file)
          when MoneyTransaction::Paypal
            TransactionsImport::Paypal.new(transactions_file)
          else
            fail 'Unknown transactions type'
        end
      end
    end

    def initialize(transactions_file)
      @csv = CSV.new(transactions_file, headers: :first_row)

      @successful_transactions = []
      @new_transactions = []
      @rejected_transactions = []
    end

    def import!
      @csv.each do |row|
        money_transaction = parse_row(row)

        transactions_container = get_transactions_container(money_transaction.new_record?, money_transaction.save)
        transactions_container << money_transaction
      end
    end

    def parse_row(row)
      field_values = initialize_field_values

      self.class::HEADERS_MAPPING.each do |field, dest_field|
        dest_value = row[dest_field]

        field_values[field] = dest_value.to_f * -1 if field == :amount_spent && flip_required?
        field_values[field] = Date.strptime(dest_value, '%m/%d/%Y') if field == :transaction_date
        field_values[field] ||= dest_value
      end

      money_transaction = MoneyTransaction.where(field_values).first_or_initialize
      money_transaction.amount_spent = 0 unless validate_row(row)
      money_transaction
    end

    def get_transactions_container(new_record, valid_record)
      if valid_record && new_record
        @new_transactions
      elsif valid_record
        @successful_transactions
      else
        @rejected_transactions
      end
    end

    def validate_row(row)
      true
    end
  end
end