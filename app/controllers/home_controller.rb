class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:google_webhook_callback]

  def index
  end

  def google_webhook_callback
    puts "In google_webhook_callback."
    puts params
    puts request.headers['X-Goog-Channel-ID']
    puts request.headers['X-Goog-Resource-ID']
    puts request.headers['X-Goog-Resource-State']
    head :ok
  end
end
