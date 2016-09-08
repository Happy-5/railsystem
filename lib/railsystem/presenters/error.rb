require "railsystem/presenters/basic"

module Railsystem
  module Presenters
    class Error < Presenters::Basic
      def self.root
        nil
      end

      def presentation
        {
          error: {
            code: status,
            message: @object
          }
        }
      end
    end
  end
end

