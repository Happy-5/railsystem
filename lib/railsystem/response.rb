require "railsystem/response/custom_message"
require "railsystem/response/object"

module Railsystem
  module Response
    extend self

    def respond_with_model(model, options = {})
      options = options.clone
      action = options.delete(:action)
      return invalid("Failed to " + action) if !model
      return created(model) if model.errors.none? && model.previous_changes[:id]
      return success(model) if model.errors.none?

      invalid(CustomMessage[model.errors, options], model)
    end

    def success(data)
      Success.new(data)
    end

    def created(data)
      Created.new(data)
    end

    def failure(error = nil, data = nil)
      Failure.new(error, data)
    end

    def not_found(error, data = nil)
      NotFound.new(error, data)
    end

    def invalid(error, data = nil)
      Invalid.new(error, data)
    end

    def not_allowed_to(action, data = nil)
      NotAllowed.new(action, data)
    end
  end
end
