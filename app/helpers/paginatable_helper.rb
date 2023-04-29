module PaginatableHelper
  def paginate(records)
    locals = {
      records: records[:records],
      current_page: records[:current_page],
      total_pages: records[:total_pages],
      per_page: records[:per_page],
      per_page_options: Paginatable::PER_PAGE_OPTIONS,
      url_helper: method(:pagination_url)
    }

    render partial: "shared/pagination", locals: locals
  end

  private

  def pagination_url(page, per_page)
    url_for(params.permit(:search).to_h.merge(page: page, per_page: per_page))
  end
end
