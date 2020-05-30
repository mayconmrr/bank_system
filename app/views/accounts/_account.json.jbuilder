# frozen_string_literal: true

json.extract! account, :id, :agency_number, :account_number, :status, :user_id, :created_at, :updated_at
json.url account_url(account, format: :json)
