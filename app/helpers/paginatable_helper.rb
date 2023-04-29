module PaginatableHelper
  def paginate(records)
    locals = {
      current_page: records[:current_page],
      total_pages: records[:total_pages],
      per_page: records[:per_page],
    }
    render partial: "shared/pagination", locals: locals
  end
end
