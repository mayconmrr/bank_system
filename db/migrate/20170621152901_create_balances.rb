class CreateBalances < ActiveRecord::Migration[5.1]
  def change
    create_table :balances do |t|
      t.float :balance, :default => '0'
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
