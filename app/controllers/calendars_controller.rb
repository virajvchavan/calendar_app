class CalendarsController < ApplicationController
  before_action :authenticate

  def index
    @calendars = current_user.calendars.as_json(only: [:id, :summary, :bg_color, :fg_color])
  end

  def events
    calendar = current_user.calendars.find(params['calendar_id'])
    redirect_to index_path unless calendar
    @calendar = calendar.as_json(only: [:id, :summary, :bg_color, :fg_color], include: :events)
  end
end