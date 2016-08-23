require "railsystem/presenters/error"

module Railsystem
  module Rails
    module Controller

      private

      def present(presenter)
        render status: presenter.status, json: presenter
      end

      def error(code, message)
        Presenters::Error.new(message, status: code)
      end
    end
  end
end

