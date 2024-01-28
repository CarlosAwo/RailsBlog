module Pagination
  extend ActiveSupport::Concern

  private

  def set_pagination_params
    @per_page = 2
    @page = params[:page].to_i || 1
  end

  def paginate(resources)
    set_pagination_params
    resources.offset((@page - 1) * @per_page).limit(@per_page)
  end

  def total_pages(resources)
    (resources.count.to_f / @per_page).ceil
  end
end
