class ApplicationController < ActionController::API
  def pagination(collection)
    Kaminari.paginate_array(collection).page(page).per(per_page)
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 10
  end
end
