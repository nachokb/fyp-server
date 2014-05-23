class ReportsController < ApplicationController

  def index
    # location_params should be nil if there's no geo
    # filter_params should be {} if there's no criteria
    Report.search_all(location_params, {}) # TODO third argument page number
  end

  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.json { render json: { id: @report.id }, status: :created }
      else
        format.json { render json: { errors: @report.errors }, status: :unprocessable_entity }
      end
    end
  end

  def candidates
    # debugger
    @report = Report.find(params[:report_id])
    render json: @report.candidates # TBD format # TODO page number
  end

  def show
    @report = Report.find(params[:id])
    render json: @report
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
