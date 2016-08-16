module Railsystem
  module Utils
    module Underscore
      def self.[](string)
        return string.underscore if string.respond_to?(:underscore)
        return string unless string =~ /[ A-Z-]|::/

        string.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
      end
    end
  end
end


