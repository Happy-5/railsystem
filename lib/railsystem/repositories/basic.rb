module Railsystem
  module Repositories
    class Basic
      include Enumerable
      attr_reader :scope

      def initialize(scope = default_scope, options = nil)
        if scope.is_a?(Hash) && !options
          options = scope
          scope = default_scope
        end

        @options = default_options.merge(options.to_h)
        @scope = scope
        apply_filters
      end

      def filter(options)
        wrap(@scope, options)
      end

      def include(*associations)
        new_repo = wrap(scope)
        associations.each do |association|
          new_scope = new_repo.send("include_#{association}")
          new_repo.instance_variable_set("@scope", new_scope) if new_scope
        end
        new_repo
      end

      def first
        load(@scope.reverse_order.reverse_order, 1)[0]
      end

      def last
        load(@scope.reverse_order, 1)[0]
      end

      def exists?
        @scope.exists?
      end

      def count(*args)
        @scope.count(*args)
      end

      def each(&block)
        load(@scope).each(&block)
      end

      def inspect
        "#<#{self.class} @options=#{@options.to_s}>"
      end

      private

      def wrap(scope, options = {})
        self.class.new(scope, @options.merge(options))
      end

      def load(scope, limit = nil)
        if limit
          scope.limit(limit)
        else
          scope
        end
      end

      def default_scope
        fail "default_scope not implemented"
      end

      def default_options
        {}
      end

      def apply_filters
        @options.each do |key, value|
          filter_method = "filter_by_#{key}"

          if respond_to?(filter_method, true)
            @scope = send(filter_method, value) || @scope
          end
        end
      end
    end
  end
end

