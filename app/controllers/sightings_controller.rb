class SightingsController < ApplicationController

  def index
    # location_params should be nil if there's no geo
    # filter_params should be {} if there's no criteria
    Sighting.search_all(location_params, {}) # TODO third argument page number
  end

  # POST /sightings.json
  def create
    @sighting = Sighting.new(sighting_params)

    respond_to do |format|
      if @sighting.save
        format.json { render json: { id: @sighting.id }, status: :created }
      else
        format.json { render json: { errors: @sighting.errors }, status: :unprocessable_entity }
      end
    end
  end

  def candidates
    # debugger
    @sighting = Report.find(params[:sighting_id])
    render json: @sighting.candidates # TBD format # TODO page number
  end

  private
  def location_params
    params.permit(:lat, :lon)
  end
  def filter_params
    params.permit(:species, :race)
  end
  def report_params
    params.require(:sighting).permit(:name, :lat, :lon, :email, :species, :race, :color, :description, :size, :age, :sex) # TODO add picture
  end
end
