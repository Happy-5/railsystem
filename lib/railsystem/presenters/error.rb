require "railsystem/presenters/basic"

module Railsystem
  module Presenters
    class Error < Presenters::Basic
      def self.root
        nil
      end

      private

      def presentation
        {
          error: {
            code: status,
            message: @object
          }
        }
      end

      def presentation_method
        :presentation
      end
    end
  end
end

