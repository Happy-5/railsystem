require "railsystem/response"
require "railsystem/presenters/array_presenter"
require "railsystem/presenters/basic_presenter"
require "railsystem/presenters/error_presenter"

module Railsystem
  module Presenters
    class ApplicationPresenter < Presenters::BasicPresenter
      def self.new(response, **options)
        return super unless response.is_a?(Response::Object)

        case response.type
        when :success
          super(response.data, status(options, 200))
        when :created
          super(response.data, status(options, 201))
        when :not_allowed
          ErrorPresenter.new(response.error, status(options, 403))
        when :not_found
          ErrorPresenter.new(response.error, status(options, 404))
        when :invalid
          ErrorPresenter.new(response.error, status(options, 422))
        else
          ErrorPresenter.new(response.error, status(options, 400))
        end
      end

      def self.status(options, default)
        {status: default}.merge!(options)
      end

      def self.array(objects, **options)
        ArrayPresenter.new(objects, **options, presenter: self)
      end
    end
  end
end

