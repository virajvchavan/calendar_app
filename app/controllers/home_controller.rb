class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:google_webhook_callback]

  def index
  end

  def google_webhook_callback
    puts "In google_webhook_callback."
    puts request.headers.to_h.slice('X-Goog-Channel-ID', 'X-Goog-Resource-ID', 'X-Goog-Resource-State', 'X-Goog-Channel-Token')

    if (request.headers['X-Goog-Channel-Token'])
      request_token = Rack::Utils.parse_nested_query request.headers['X-Goog-Channel-Token']
      user = User.find_by(id: request_token['userId'])

      unless user
        puts "Webhook error: User not found"
        head :ok
      end

      case request_token['type']
      when 'calendars'
        user.load_calendars_with_events
      when 'events'
        calendar = user.calendars.find_by(g_id: request_token['cId'])
        unless calendar
          puts "Webhook error: Calendar not found"
          head :ok
        end
        user.load_events(calendar, GoogleCalendarApi.new(user.google_token))
      end
    end
    head :ok
  end
end
