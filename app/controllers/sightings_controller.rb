class SightingsController < ApplicationController

  def index
    # location_params should be nil if there's no geo
    # filter_params should be {} if there's no criteria
    render json: Sighting.search_all(location_params, {}) # TODO third argument page number
  end

  # POST /sightings.json
  def create
    @sighting = Sighting.new(sighting_params)

    if @sighting.save
      render json: { id: @sighting.id }, status: :created
    else
      render json: { errors: @sighting.errors }, status: :unprocessable_entity
    end
  end

  def candidates
    # debugger
    @sighting = Sighting.find(params[:sighting_id])
    render json: @sighting.candidates # TBD format # TODO page number
  end

  def show
    @sighting = Sighting.find(params[:id])
    render json: @sighting
  end

  private
  def location_params
    params.permit(:lat, :lon)
  end
  def filter_params
    params.permit(:species, :race)
  end
  def sighting_params
    params.require(:sighting).permit(:name, :lat, :lon, :email, :species, :race, :color, :description, :size, :age, :sex, :picture)
  end
end
