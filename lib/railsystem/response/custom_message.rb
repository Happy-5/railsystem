module Railsystem
  module Response
    module CustomMessage
      def self.[](errors, errmap)
        result = []

        errmap.each do |error_key, message|
          result << message if errors.added?(*Array(error_key))
        end

        if result.empty?
          errors.to_a
        else
          result
        end
      end
    end
  end
end


