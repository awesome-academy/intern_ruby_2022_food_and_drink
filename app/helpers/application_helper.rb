module ApplicationHelper
  def full_title page_title
    base_title = t ".base_title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def check_valid_date params, value
    if params.present?
      params[value].blank? ? "" : params[value].to_date
    else
      ""
    end
  end

  include Pagy::Frontend
end
