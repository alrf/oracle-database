
require File.join(File.dirname(__FILE__), 'resource_database')

class Chef
  class Resource
    class DatabaseUser < Chef::Resource::Database
      def initialize(name, run_context = nil)
        super
        @resource_name = :database_user
        @username = name

        @table = nil
        @privileges = [:select]

        @allowed_actions.push(:create, :drop, :grant, :revoke)
        @action = :create
      end

      def username(arg = nil)
        set_or_return(
          :username,
          arg,
          kind_of: String
        )
      end

      def password(arg = nil)
        set_or_return(
          :password,
          arg,
          {:kind_of => String, :required => true}
        )
      end

      def table(arg = nil)
        set_or_return(
          :table,
          arg,
          kind_of: String
        )
      end

      def privileges(arg = nil)
        set_or_return(
            :privileges,
            arg,
            kind_of: Array
        )
      end

    end
  end
end
