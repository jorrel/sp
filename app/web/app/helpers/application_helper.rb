# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def table(html_options = {}, &block)
    html_options.reverse_update(:cellspacing => 0, :cellpadding => 0)
    content_tag(:table, html_options, &block)
  end
end
