
require File.join(File.dirname(__FILE__), 'provider_database_oracle')

class Chef
  class Resource
    class OracleDatabase < Chef::Resource::Database
      def initialize(name, run_context = nil)
        super
        @resource_name = :oracle_database
        @provider = Chef::Provider::Database::Oracle
      end
    end
  end
end
