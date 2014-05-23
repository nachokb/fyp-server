class ReportsController < ApplicationController
  def index
    Report.search_all(safe_params)
  end

  private
  def safe_params
    params.permit(:lat, :lon)
  end
end
