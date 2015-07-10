
require File.join(File.dirname(__FILE__), 'resource_database')

class Chef
  class Resource
    class DatabaseTable < Chef::Resource::Database
      def initialize(name, run_context = nil)
        super
        @resource_name = :database_table
        @table = name

        @database_name = nil
        @allowed_actions.push(:create, :drop)
        @action = :create
      end

      def columns(arg = nil)
        set_or_return(
            :privileges,
            arg,
            {:kind_of => Array, :required => true}
        )
      end

      def table(arg = nil)
        set_or_return(
            :table,
            arg,
            kind_of: String
        )
      end

    end
  end
end
