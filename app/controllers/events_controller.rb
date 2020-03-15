class EventsController < ApplicationController
  before_action :authenticate

  def daily
    @calendars = current_user.calendars.as_json(methods: :daily_events, only: [:id, :summary, :bg_color, :fg_color])
  end
end
