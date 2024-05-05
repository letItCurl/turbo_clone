# Fine to put it her with the rails archi
class TurboClone::Streams::TagBuilder
  def initialize(view_content)
    @view_content = view_content
    @view_content.formats |= [:html]
  end

  def replace(target, content = nil, **rendering, &block)
    action :replace, target, content, **rendering, &block
  end

  def action(name, target, content = nil, **rendering, &block)
    template = render_template(target, content, **rendering, &block)

    turbo_stream_action_tag(name, target: target, template: template)
  end

  def turbo_stream_action_tag(action, target:, template:)
    template = "<template>#{template}</template>"

    if target = convert_to_turbo_stream_dom_id(target)
      %(<turbo-stream target="#{target}" action="#{action}">#{template}</turbo-stream>).html_safe
    else
      raise ArgumentError, "target must be supplied"
    end
  end

  def render_template(target, content = nil,  **rendering, &block)
    if content
      content
    elsif block_given?
      @view_content.capture(&block)
    elsif rendering.any?
      @view_content.render(**rendering, formats: :html)
    else
      @view_content.render(partial: target, formats: :html)
    end
  end

  def convert_to_turbo_stream_dom_id(target)
    if target.respond_to?(:to_key)
      ActionView::RecordIdentifier.dom_id(target)
    else
      target
    end
  end
end
