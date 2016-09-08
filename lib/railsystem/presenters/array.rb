require "railsystem/response"
require "railsystem/presenters/basic"

module Railsystem
  module Presenters
    class Array < Presenters::Basic
      def initialize(objects, **options)
        @objects = objects.is_a?(Response::Object) ? objects.data : objects
        @options = options.dup
        @options[:status] = infer_status(options[:status])
      end

      def element_presenter
        @options[:presenter]
      end

      def presentation
        @objects.map {|o| element_presenter.new(o, @options).presentation }
      end

      private

      def root_key
        element_presenter.root
      end
    end
  end
end

