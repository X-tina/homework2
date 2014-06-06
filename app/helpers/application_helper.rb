module ApplicationHelper
  def sortable(column, title = nil)
    p "!!!!", title
    title ||= column.titleize
    direction = (column == params[:movies_sort] && params[:direction] == "ASC") ? "DESC" : "ASC"
    (params[:direction] == "ASC") ? arrow = "&darr;".html_safe : arrow = "&uarr;".html_safe
    #title += ' ' + "#{arrow}"
    link_to "#{title} #{arrow}".html_safe, movies_path(:movies_sort => column, :direction => direction.to_s)
  end
end
