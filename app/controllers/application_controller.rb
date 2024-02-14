class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def index
    @appointments = Appointment.all
  end

  def default_url_options
    { host: ENV["www.thehealthbook.online"] || "localhost:3000" }
  end
end
