class ReportsController < ApplicationController
  def index
    # sort_params should be nil if there's no geo
    # filter_params should be {} if there's no criteria
    Report.search_all(sort_params, {})
  end

  def create

  end

  private
  def sort_params
    params.permit(:lat, :lon)
  end
  def filter_params
    params.permit(:species, :race)
  end
end
