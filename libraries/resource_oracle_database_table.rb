
require File.join(File.dirname(__FILE__), 'resource_database_table')
require File.join(File.dirname(__FILE__), 'provider_database_oracle_table')

class Chef
  class Resource
    class OracleDatabaseTable < Chef::Resource::DatabaseTable
      def initialize(name, run_context = nil)
        super
        @resource_name = :oracle_database_table
        @provider = Chef::Provider::Database::OracleTable
      end
    end
  end
end
