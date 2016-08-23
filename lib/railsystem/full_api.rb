require "railsystem"
require "railsystem/railtie"

module Railsystem
  class Railtie < ::Rails::Railtie
    initializer "railsystem.error_handling" do |app|
      app.middleware.swap("ActionDispatch::ShowExceptions",
                          "Railsystem::Middlewares::JsonError")
    end

    initializer "railsystem.presenters.renderer" do |app|
      ApplicationController.include Railsystem::Rails::Controller
    end
  end
end

