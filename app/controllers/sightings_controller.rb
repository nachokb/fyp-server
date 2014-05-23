class SightingsController < ApplicationController
  def index
    Sighting.search_all(safe_params)
  end

  private
  def safe_params
    params.permit(:lat, :lon)
  end
end
