module TurboClone::Broadcastable
  extend ActiveSupport::Concern

  class_methods do
    def broadcast_target_default
      model_name.plural
    end
  end

  def broadcast_append_to(*streamables, target: broadcast_target_default, **rendering)
    TurboClone::StreamsChannel.broadcast_append_to(*streamables, target: target, **broadcast_rendering_with_defaults(rendering))
  end

  private

  def broadcast_rendering_with_defaults(rendering)
    rendering.tap do |r|
      r[:locals] = (r[:locals] || {}).reverse_merge!(model_name.element.to_sym => self)
      r[:locals] ||= self.to_partial_path
    end
  end

  def broadcast_target_default
    self.class.broadcast_target_default
  end
end
