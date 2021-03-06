require "railsystem"
require "railsystem/railtie"

module Railsystem
  class Railtie < ::Rails::Railtie
    initializer "railsystem.error_handling" do |app|
      app.config.action_dispatch.show_exceptions = false
      app.middleware.swap("ActionDispatch::ShowExceptions",
                          "Railsystem::Middlewares::JsonError")
    end
  end
end

