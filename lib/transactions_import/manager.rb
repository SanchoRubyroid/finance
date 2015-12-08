require 'csv'

module TransactionsImport
  class Manager
    def initialize(transactions_file)
      @csv = CSV.new(transactions_file, headers: :first_row)

      @csv.each do |row|
        row
      end
    end


  end
end