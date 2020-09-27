# frozen_string_literal: true

class EventsController < ApplicationController
  def check; end

  def availabilities
    @day = DateTime.parse(params[:day])
    @availabilities = Event.availabilities(@day)
  end
end
