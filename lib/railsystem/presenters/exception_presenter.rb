require "railsystem/presenters/error_presenter"

module Railsystem
  module Presenters
    class ExceptionPresenter < Presenters::ErrorPresenter
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

      private

      def backtrace
        @object.backtrace && Rails.backtrace_cleaner.clean(@object.backtrace)
      end
    end
  end
end

