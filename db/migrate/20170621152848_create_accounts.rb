class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :agency_number
      t.integer :account_number
      t.boolean :status, :default => '0'
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
