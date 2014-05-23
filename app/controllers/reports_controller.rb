class ReportsController < ApplicationController

  def index
    # sort_params should be nil if there's no geo
    # filter_params should be {} if there's no criteria
    Report.search_all(location_params, {})
  end

  # POST /pruebas
  # POST /pruebas.json
  def create
    debugger
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.json { render json: { }, status: :created }
      else
        format.json { render json: { errors: @report.errors }, status: :unprocessable_entity }
      end
    end
  end

  private
  def location_params
    params.permit(:lat, :lon)
  end
  def filter_params
    params.permit(:species, :race)
  end
  def report_params
    params.require(:report).permit(:name, :lat, :lon, :email, :species, :race, :color, :description, :size, :age, :sex) # TODO add picture
  end
end
