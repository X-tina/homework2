module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:movies_sort] && params[:direction] == "ASC") ? "DESC" : "ASC"
    link_to title, :movies_sort => column, :direction => direction.to_s
  end
end
