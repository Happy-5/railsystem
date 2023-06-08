module Railsystem
  module Presenters
    class Basic
      def self.root
        nil
      end

      def initialize(object, options = {})
        @options = options.dup
        @options[:status] = infer_status(options[:status])
        @options[:use] ||= :presentation
        @object = object
      end

      def root
        return self unless root_key

        Basic.new({ root_key => as_json }, **@options.except(:use))
      end

      def status
        @options[:status]
      end

      def as_json(*args)
        return nil if @object.nil?

        send(presentation_method).as_json(*args)
      end

      def to_json(*args)
        return nil if @object.nil?

        send(presentation_method).to_json(*args)
      end

      private

      def presentation
        @object.to_h
      end

      def presentation_method
        @options[:use]
      end

      def root_key
        self.class.root
      end

      def infer_status(status)
        status ||= :ok

        Rack::Utils::SYMBOL_TO_STATUS_CODE[status] || status
      end
    end
  end
end
