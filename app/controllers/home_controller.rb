class HomeController < ApplicationController
  def index
  end

  def google_webhook_callback
    puts "In google_webhook_callback."
    puts request.to_json
    puts params
    head :ok
  end
end
