module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:movies_sort] && params[:direction] == "ASC") ? "DESC" : "ASC"
    (params[:direction] == "ASC") ? arrow = "&darr;".html_safe : arrow = "&uarr;".html_safe
    link_to "#{title} #{arrow}".html_safe, :movies_sort => column, :direction => direction.to_s
  end
end
