require "railsystem/presenters/application_presenter"

module Railsystem
  module Presenters
    class ErrorPresenter < Presenters::ApplicationPresenter
      def initialize(code, error)
        @code = Rack::Utils::SYMBOL_TO_STATUS_CODE[code] || code
        @error = error
      end

      def presentation
        {
          error: {
            code: @code,
            message: @error
          }
        }
      end

      def status
        @code
      end
    end
  end
end

