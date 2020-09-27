# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'events#check'
  get 'availabilities', to: 'events#availabilities'
end
