module Railsystem
  module Presenters
    class Basic
      def initialize(object, **options)
        @options = options.dup
        @options[:status] = infer_status(options[:status])
        @object = object
      end

      def presentation
        @object.to_h
      end

      def status
        @options[:status]
      end

      def as_json(*args)
        presentation.as_json(*args)
      end

      def to_json(*args)
        presentation.to_json(*args)
      end

      private

      def infer_status(status)
        status = status || :ok
        status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] || status
      end
    end
  end
end

