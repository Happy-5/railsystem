require "railsystem/middlewares/base"

module Railsystem
  module Middlewares
    class JsonError < Middlewares::Base

      def call(env)
        @app.call(env)
      rescue ::Exception => error
        $stderr.puts "#{error}\n  #{error.backtrace * "\n  "}"
        render_error(env, error)
      end

      private

      def render_error(env, err)
        debug = ::Rails.application.config.consider_all_requests_local

        case err
        when ::ActionDispatch::Http::Parameters::ParseError
          return error(400, <<-ERROR.squish)
            There was a problem in the JSON you submitted: #{err}
          ERROR

        when ::ActionController::RoutingError
          return error(404, <<-ERROR.squish)
            No route matches [#{env['REQUEST_METHOD']}]
            #{env['PATH_INFO'].inspect}
          ERROR

        when ::ActionController::ParameterMissing
          return error(400, err.message)

        else
          return error(500, debug ? err : <<-ERROR.squish)
            Sorry, there's an error on our side. We're working on it!
          ERROR

        end
      end
    end
  end
end

