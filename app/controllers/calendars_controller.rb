class CalendarsController < ApplicationController
  before_action :authenticate

  def index
    @calendars = current_user.calendars.as_json(only: calendar_json_params)
  end

  def events
    calendar = current_user.calendars.find_by(id:params['calendar_id'])
    redirect_to calendars_index_path unless calendar
    @calendar = calendar.as_json(only: calendar_json_params, include: :active_events)
  end

  private
  def calendar_json_params
    %i[id summary bg_color fg_color]
  end
end
