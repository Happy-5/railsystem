require "railsystem"
require "railsystem/railtie"

module Railsystem
  class Railtie < ::Rails::Railtie
    initializer "railsystem.error_handling" do |app|
      app.middleware.swap("ActionDispatch::ShowExceptions",
                          "Railsystem::Middlewares::JsonErrorMiddleware")
    end
  end
end

