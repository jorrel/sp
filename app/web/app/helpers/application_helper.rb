# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def table(html_options = {}, &block)
    html_options.reverse_update(:cellspacing => 0, :cellpadding => 0)
    content_tag(:table, html_options, &block)
  end

  def display_time(time, strformat = Time::DATE_FORMATS[:short])
    time = time.in_time_zone('Asia/Manila')
    if strformat.respond_to?(:call)
      strformat.call(time).to_s
    else
      time.strftime(strformat)
    end
  end
end

#
# Override the wrapping field error proc
#
ActionView::Base.field_error_proc = Proc.new { |contents, instance|
  error_details = [*instance.object.errors.on(instance.method_name)].first
  <<-field_with_error
    <span class="field-with-errors">#{contents}</span>
    <br />
    <span class="field-error-detail">#{error_details}</span>
  field_with_error
}