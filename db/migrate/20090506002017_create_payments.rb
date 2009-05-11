class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments, :force => true  do |t|
      t.integer :cart_id
      t.decimal :amount
      t.string :transaction_id
      t.string :status
      t.string :who
      t.string :params
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
