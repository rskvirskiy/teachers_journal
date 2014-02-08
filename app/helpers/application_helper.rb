module ApplicationHelper
  def page_title(separator = ' – ')
    [content_for(:title), t(:application)].compact.join(separator)
  end
end