require "rails/railtie"
require "railsystem/middlewares/json_error_middleware"

module Railsystem
  class Railtie < Rails::Railtie
    config.eager_load_namespaces << Railsystem

    initializer "railsystem.error_handling" do |app|
      app.middleware.swap("ActionDispatch::ShowExceptions",
                          "Railsystem::Middlewares::JsonErrorMiddleware")
    end
  end
end

