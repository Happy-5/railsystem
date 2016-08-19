require "railsystem/presenters/basic_presenter"

module Railsystem
  module Presenters
    class ErrorPresenter < Presenters::BasicPresenter
      def presentation
        {
          error: {
            code: status,
            message: @object
          }
        }
      end
    end
  end
end

