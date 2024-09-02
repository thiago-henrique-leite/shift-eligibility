class ApplicationController < ActionController::API
  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 10
  end
end
