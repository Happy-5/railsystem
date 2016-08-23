require "railsystem/middlewares/base"

module Railsystem
  module Middlewares
    class JsonError < Middlewares::Base

      def call(env)
        @app.call(env)
      rescue ::Exception => error
        render_error(env, error)
      end

      private

      def render_error(env, error)
        debug = ::Rails.application.config.consider_all_requests_local

        case error
        when ::ActionDispatch::ParamsParser::ParseError
          return error(400, <<-ERROR.squish)
        There was a problem in the JSON you submitted: #{error}
          ERROR

        when ::ActionController::RoutingError
          return error(404, <<-ERROR.squish)
        No route matches [#{env['REQUEST_METHOD']}] #{env['PATH_INFO'].inspect}
          ERROR

        when ::ActionController::ParameterMissing
          return error(400, error.message)

        else
          return error(500, debug ? error : <<-ERROR.squish)
        Sorry, there's an error on our side. We're working on it!
          ERROR

        end
      end
    end
  end
end

