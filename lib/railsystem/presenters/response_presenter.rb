require "railsystem/presenters/application_presenter"
require "railsystem/presenters/error_presenter"

module Railsystem
  module Presenters
    class ResponsePresenter < Presenters::ApplicationPresenter
      def response
        @object
      end

      def presentation
        response.data
      end

      def status
        case response.type
        when :created
          201
        else
          200
        end
      end

      def self.new(response, *args)
        case response.type
        when :success, :created
          super
        when :not_found
          ErrorPresenter.new(404, response.error)
        when :invalid
          ErrorPresenter.new(422, response.error)
        when :not_allowed
          ErrorPresenter.new(403, response.error)
        else
          ErrorPresenter.new(400, response.error)
        end
      end
    end
  end
end

