require "railsystem/presenters/error_presenter"

module Railsystem
  module Rails
    module Controller

      private

      def present(presenter)
        render status: presenter.status, json: presenter
      end

      def error(code, message)
        Presenters::ErrorPresenter.new(message, status: code)
      end
    end
  end
end

