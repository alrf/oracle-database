
require File.join(File.dirname(__FILE__), 'resource_database_user')
require File.join(File.dirname(__FILE__), 'provider_database_oracle_user')

class Chef
  class Resource
    class OracleDatabaseUser < Chef::Resource::DatabaseUser
      def initialize(name, run_context = nil)
        super
        @resource_name = :oracle_database_user
        @provider = Chef::Provider::Database::OracleUser
      end
    end
  end
end
