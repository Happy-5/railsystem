require "railsystem/response"
require "railsystem/presenters/array"
require "railsystem/presenters/basic"
require "railsystem/presenters/error"

module Railsystem
  module Presenters
    class Base < Presenters::Basic
      def self.new(response, options = {})
        return super unless response.is_a?(Response::Object)

        case response.type
        when :success
          super(response.data, status(options, 200))
        when :created
          super(response.data, status(options, 201))
        else
          failure(response, options.except(:status))
        end
      end

      def self.failure(response, options)
        case response.type
        when :unauthenticated
          error_presenter(response.error, status(options, 401))
        when :not_allowed
          error_presenter(response.error, status(options, 403))
        when :not_found
          error_presenter(response.error, status(options, 404))
        when :invalid
          error_presenter(response.error, status(options, 422))
        else
          error_presenter(response.error, status(options, 400))
        end
      end

      def self.status(options, default)
        { status: default }.merge!(options)
      end

      def self.array(objects, options = {})
        if objects.respond_to?(:success?) && !objects.success?
          failure(objects, options.except(:status))
        else
          options[:presenter] = self
          Presenters::Array.new(objects, options)
        end
      end

      def self.error_presenter(*args)
        Presenters::Error.new(*args)
      end
    end
  end
end
