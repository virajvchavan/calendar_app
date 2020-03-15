class EventsController < ApplicationController
  before_action :authenticate
  def index
    service = GoogleCalendarApi.new(current_user.google_token)
    @events = service.calendar_events[:items]
  end
end
