module ApplicationHelper

  # Returns the full title on a per-page basis.
  # To solve the problem of a missing page title, 
  # we’ll define a custom helper called full_title.
  # The full_title helper returns a base title, “Ruby on Rails 
  # Tutorial Sample App”, if no page title is defined, and adds 
  # a vertical bar followed by the page title if one is defined.
  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end