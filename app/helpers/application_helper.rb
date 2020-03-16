module ApplicationHelper
  def format_event_duration(event, action)
    if action == 'daily' && event['all_day_event']
      return "<p class='chip'>All day</p>".html_safe
    end

    format = event['all_day_event'] ? '%d %b %Y' : '%d %b %Y %H:%M UTC'

    html = "<p>"
    html += "<div class='chip'>#{get_time(event['start_time'],format)} </div> - "
    html += "<div class='chip'>#{get_time(event['end_time'],format)}</div>"
    html += "</p>"
    html.html_safe
  end

  def get_time(datetime_string, format)
    DateTime.parse(datetime_string).strftime(format)
  end
end
