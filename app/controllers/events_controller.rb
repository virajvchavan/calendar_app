class EventsController < ApplicationController
  before_action :authenticate
  def index
    @events = current_user.calendars.map(&:events)
  end
end
