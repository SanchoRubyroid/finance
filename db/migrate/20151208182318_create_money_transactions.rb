class CreateMoneyTransactions < ActiveRecord::Migration
  def change
    create_table :money_transactions, force: true do |t|
      t.string :name
      t.date :transaction_date
      t.string :system_type
      t.decimal :amount_spent, precision: 8, scale: 2
      t.decimal :amount_spent_olya, precision: 8, scale: 2
      t.string :currency, limit:3

      t.timestamps null: false
    end

    add_index(:money_transactions, :name)
    add_index(:money_transactions, :transaction_date)
  end
end
