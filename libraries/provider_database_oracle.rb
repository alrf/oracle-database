
class Chef
  class Provider
    class Database
      class Oracle < Chef::Provider::LWRPBase
        use_inline_resources if defined?(use_inline_resources)

        def whyrun_supported?
          true
        end

        action :query do
          begin
            query_sql = new_resource.sql_query
            repair_client.exec(query_sql)
            repair_client.commit if new_resource.commit
          ensure
            close_repair_client
          end
        end

        private

        def test_client
          require 'oci8'
          @test_client ||=
            OCI8.new(
            new_resource.connection[:username],
            new_resource.connection[:password],
            new_resource.connection[:host]
            )
        end

        def close_test_client
          @test_client.logoff if @test_client
        rescue OCI8::OCIException
          @test_client = nil
        end

        def repair_client
          require 'oci8'
          @repair_client ||=
            OCI8.new(
            new_resource.connection[:username],
            new_resource.connection[:password],
            new_resource.connection[:host]
            )
        end

        def close_repair_client
          @repair_client.logoff if @repair_client
        rescue OCI8::OCIException
          @repair_client = nil
        end

      end
    end
  end
end
