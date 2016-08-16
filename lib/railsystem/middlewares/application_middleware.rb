require "railsystem/presenters/error_presenter"

module Railsystem
  module Middlewares
    class ApplicationMiddleware
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      end

      private

      def error(code, error)
        presenter = if error.is_a?(Exception)
                      Presenters::ExceptionPresenter
                    else
                      Presenters::ErrorPresenter
                    end
        view = presenter.new(code, error)
        charset = ActionDispatch::Response.default_charset
        json = view.to_json
        headers = {
          "Content-Type" => "application/json; charset=#{charset}",
          "Content-Length" => json.bytesize.to_s
        }

        [view.status, headers, [json]]
      end
    end
  end
end
