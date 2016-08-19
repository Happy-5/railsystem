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

      def error(status, error)
        presenter = if error.is_a?(Exception)
                      Presenters::ExceptionPresenter
                    else
                      Presenters::ErrorPresenter
                    end
        json = presenter.new(error, status: status).to_json
        charset = ActionDispatch::Response.default_charset
        headers = {
          "Content-Type" => "application/json; charset=#{charset}",
          "Content-Length" => json.bytesize.to_s
        }

        [status, headers, [json]]
      end
    end
  end
end
