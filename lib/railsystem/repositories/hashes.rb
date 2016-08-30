require "railsystem/repositories/basic"

module Railsystem
  module Repositories
    class Hashes < Repositories::Basic
      def load(scope, limit = nil)
        scope = super
        sql = scope.klass.send(:sanitize_sql, scope.arel)
        binds = scope.arel.bind_values + scope.bind_values
        action = "#{scope.name} Load"

        result_set = scope.connection.select_all(sql, action, binds)
        column_types = result_set.column_types.dup

        result_set.map do |record|
          hash = {}
          record.each do |key, val|
            hash[key.to_sym] = column_types[key].send(:type_cast, val)
          end
          hash
        end
      end
    end
  end
end

