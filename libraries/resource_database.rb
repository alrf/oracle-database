
require 'chef/resource'

class Chef
  class Resource
    class Database < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :database
        @database_name = name
        @allowed_actions.push(:create, :drop, :query)
        @action = :create
      end

      def database_name(arg = nil)
        set_or_return(
          :database_name,
          arg,
          kind_of: String
        )
      end

      def connection(arg = nil)
        set_or_return(
          :connection,
          arg,
          required: true
        )
      end

      def sql_query(arg = nil)
        set_or_return(
            :sql_query,
            arg,
            kind_of: String,
            required: true
        )
      end
=begin
      def sql(arg = nil, &block)
        arg ||= block
        set_or_return(
          :sql,
          arg,
          kind_of: [String, Proc]
        )
      end

      def sql_query
        if sql.is_a?(Proc)
          sql.call
        else
          sql
        end
      end
=end
      def template(arg = nil)
        set_or_return(
          :template,
          arg,
          kind_of: String,
          default: 'DEFAULT'
        )
      end

      def collation(arg = nil)
        set_or_return(
          :collation,
          arg,
          kind_of: String
        )
      end

      def commit(arg = nil)
        set_or_return(
            :commit,
            arg,
            kind_of: [ TrueClass, FalseClass ],
            default: false
        )
      end

      def encoding(arg = nil)
        set_or_return(
          :encoding,
          arg,
          kind_of: String,
          default: 'DEFAULT'
        )
      end

      def tablespace(arg = nil)
        set_or_return(
          :tablespace,
          arg,
          kind_of: String,
          default: 'DEFAULT'
        )
      end

      def connection_limit(arg = nil)
        set_or_return(
          :connection_limit,
          arg,
          kind_of: String,
          default: '-1'
        )
      end

      def owner(arg = nil)
        set_or_return(
          :owner,
          arg,
          kind_of: String
        )
      end
    end
  end
end
