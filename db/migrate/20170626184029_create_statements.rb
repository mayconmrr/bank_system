# frozen_string_literal: true

class CreateStatements < ActiveRecord::Migration[5.1]
  def change
    create_table :statements do |t|
      t.float :balance
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
