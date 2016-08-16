require "railsystem/presenters/error_presenter"

module Railsystem
  module Presenters
    class ExceptionPresenter < Presenters::ErrorPresenter
      def presentation
        {
          error: {
            code: @code,
            message: @error.message,
            exception: @error.class.name,
            backtrace: backtrace
          }
        }
      end

      private

      def backtrace
        @error.backtrace && Rails.backtrace_cleaner.clean(@error.backtrace)
      end
    end
  end
end
