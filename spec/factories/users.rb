# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name 'Usuario 1'
    email 'exemplo1@ex1.com'
    gender 'Masculino'
    password '123456'
    password_confirmation '123456'
  end
end
