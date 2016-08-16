module Railsystem
  module Presenters
    class ApplicationPresenter
      def initialize(object)
        @object = object
      end

      def presentation
        {}
      end

      def status
        200
      end

      def as_json(*args)
        presentation.as_json(*args)
      end

      def to_json(*args)
        presentation.to_json(*args)
      end
    end
  end
end



