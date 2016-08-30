require "railsystem"
require "railsystem/rails/controller"
require "rails/railtie"

module Railsystem
  class Railtie < ::Rails::Railtie
    initializer "railsystem.presenters.renderer" do |app|
      ApplicationController.include Railsystem::Rails::Controller
    end
  end
end

