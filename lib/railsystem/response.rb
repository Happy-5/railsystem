require "railsystem/response/custom_message"
require "railsystem/response/object"

module Railsystem
  module Response
    extend self

    def respond_with_model(model, options = {})
      options = options.clone
      action = options.delete(:action)
      error_message = action ? "Failed to #{action}" : "Action failed"

      return invalid(error_message) if !model
      return invalid_model(model, options) if model.errors.any?
      return created(model) if model.previous_changes[:id]
      return success(model)
    end

    def success(data = nil)
      Success.new(data)
    end

    def created(data = nil)
      Created.new(data)
    end

    def failure(error = nil, data = nil)
      Failure.new(error, data)
    end

    def not_found(error = nil, data = nil)
      NotFound.new(error, data)
    end

    def invalid(error = nil, data = nil)
      Invalid.new(error, data)
    end

    def invalid_model(model, options = {})
      invalid(CustomMessage[model.errors, options], model)
    end

    def not_allowed(error = nil, data = nil)
      NotAllowed.new(error, data)
    end
  end
end
