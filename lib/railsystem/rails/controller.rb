require "railsystem/presenters/error"

module Railsystem
  module Rails
    module Controller

      private

      def present(presenter)
        render status: presenter.status, json: presenter.root
      end

      def error(code, message)
        response = Railsystem::Response.failure(message)
        default_presenter.failure(response, status: code)
      end

      def failure(response, **options)
        default_presenter.failure(response, **options)
      end

      def default_presenter
        Railsystem::Presenters::Base
      end
    end
  end
end

