module DeviseHelper
  def devise_error_messages!
    errors = resource.errors
    return '' if errors.empty?

    messages = errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger fade in"> <button type="button"
    class="close" data-dismiss="alert">x</button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end