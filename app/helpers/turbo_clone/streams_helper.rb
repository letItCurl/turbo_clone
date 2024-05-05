module TurboClone::StreamsHelper
  def turbo_stream
    # self == view context
    TurboClone::Streams::TagBuilder.new(self)
  end
end
