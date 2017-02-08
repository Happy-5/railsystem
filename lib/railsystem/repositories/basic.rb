module Railsystem
  module Repositories
    class Basic
      include Enumerable
      def initialize(scope = default_scope, options = nil, includes = nil)
        if scope.is_a?(Hash) && !includes
          includes = options
          options = scope
          scope = default_scope
        end

        @options = Hash(default_options.merge(options.to_h))
        @includes = Array(includes)
        @scope = scope
        setup
        apply_filters(@options)
        apply_includes(@includes)
      end

      def initialize_copy(repo)
        super
        @scope = repo.scope
        @options = repo.options
        @includes = repo.includes
      end

      def scope
        @scope.clone
      end

      def options
        @options.clone
      end

      def includes
        @includes.clone
      end

      def filter(options)
        new_repo = clone
        new_repo.instance_variable_set("@options", @options.merge(options))
        new_repo.send(:apply_filters, options)
        new_repo
      end

      def include(*associations)
        new_repo = clone
        new_repo.instance_variable_set("@includes", @includes | associations)
        new_repo.send(:apply_includes, associations)
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

      def setup
      end

      def update_scope(scope)
        new_repo = clone
        new_repo.instance_variable_set("@scope", scope)
        new_repo
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

      def apply_filters(options)
        options.each do |key, value|
          method = "filter_by_#{key}"

          if respond_to?(method, true)
            @scope = send(method, value) || @scope
          end
        end
      end

      def apply_includes(associations)
        associations.each do |value|
          method = "include_#{value}"
          @scope = send(method) || @scope
        end
      end
    end
  end
end

