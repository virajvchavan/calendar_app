class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:google_webhook_callback]

  def index
  end

  def google_webhook_callback
    puts "In google_webhook_callback."
    puts request.to_json
    puts params
    head :ok
  end
end
