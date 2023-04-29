module Paginatable
  extend ActiveSupport::Concern

  PER_PAGE_OPTIONS = [25, 50, 100].freeze

  included do
    def self.search_page(page, per, order = :asc)
      per_page = per.blank? ? Paginatable::PER_PAGE_OPTIONS.first : per.to_i
      total_count = self.count
      current_page = (page.to_i - 1) < 0 ? 0 : page.to_i

      if current_page.zero?
        records = limit(per_page)
      else
        if order == :desc
          records = where("id <= ?", ((total_count / per_page.to_f).ceil - current_page) * per_page).limit(per_page)
        else
          records = where("id > ?", current_page * per_page).limit(per_page)
        end
      end

      {
        records: records,
        current_page: current_page,
        total_pages: (total_count / per_page.to_f).ceil,
        per_page: per_page
      }
    end
  end
end
