require "railsystem/repositories/basic"

module Railsystem
  module Repositories
    class Base < Repositories::Basic
      def hashes
        Repositories::Hashes.new(@scope, @options)
      end
    end
  end
end


