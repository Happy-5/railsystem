require "railsystem/presenters/basic"

module Railsystem
  module Presenters
    class Error < Presenters::Basic
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

