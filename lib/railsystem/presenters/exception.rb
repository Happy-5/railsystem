require "railsystem/presenters/error"

module Railsystem
  module Presenters
    class Exception < Presenters::Error
      private

      def presentation
        {
          error: {
            code: status,
            message: @object.message,
            exception: @object.class.name,
            backtrace: backtrace
          }
        }
      end

      def presentation_method
        :presentation
      end

      def backtrace
        @object.backtrace && ::Rails.backtrace_cleaner.clean(@object.backtrace)
      end
    end
  end
end

