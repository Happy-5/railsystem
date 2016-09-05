require "railsystem/response"
require "railsystem/presenters/array"
require "railsystem/presenters/basic"
require "railsystem/presenters/error"

module Railsystem
  module Presenters
    class Base < Presenters::Basic
      def self.new(response, **options)
        return super unless response.is_a?(Response::Object)

        case response.type
        when :success
          super(response.data, status(options, 200))
        when :created
          super(response.data, status(options, 201))
        when :not_allowed
          Presenters::Error.new(response.error, status(options, 403))
        when :not_found
          Presenters::Error.new(response.error, status(options, 404))
        when :invalid
          Presenters::Error.new(response.error, status(options, 422))
        else
          Presenters::Error.new(response.error, status(options, 400))
        end
      end

      def self.status(options, default)
        {status: default}.merge!(options)
      end

      def self.array(objects, **options)
        Presenters::Array.new(objects, **options, presenter: self)
      end
    end
  end
end
