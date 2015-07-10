
require File.join(File.dirname(__FILE__), 'provider_database_oracle')

class Chef
  class Provider
    class Database
      class OracleTable < Chef::Provider::Database::Oracle
        use_inline_resources if defined?(use_inline_resources)

        def whyrun_supported?
          true
        end

        action :create do
          unless table_present?
            table_owner = new_resource.owner ? "#{new_resource.owner}" : 'system'
            converge_by "Creating table '#{table_owner}.#{new_resource.table}'" do
              begin
                repair_sql = "CREATE TABLE #{table_owner}.#{new_resource.table} ("
                repair_sql += new_resource.columns.map(&:upcase).join(', ')
                repair_sql += ")"
                #p repair_sql
                repair_client.exec(repair_sql)
              ensure
                close_repair_client
              end
            end
          end
        end

        action :drop do
          if table_present?
            table_owner = new_resource.owner ? "#{new_resource.owner}" : 'system'
            converge_by "Dropping table '#{table_owner}.#{new_resource.table}'" do
              begin
                repair_sql = "DROP TABLE #{table_owner}.#{new_resource.table}"
                repair_client.exec(repair_sql)
              ensure
                close_repair_client
              end
            end
          end
        end

        private

        def table_present?
          table_owner = new_resource.owner ? "#{new_resource.owner}" : 'system'
          table_present = nil
          begin
            test_sql = "SELECT count(1) AS cnt FROM ALL_TABLES WHERE TABLE_NAME=UPPER('#{new_resource.table}') AND OWNER=UPPER('#{table_owner}')"
            test_sql_results = test_client.exec(test_sql)
            r = test_sql_results.fetch_hash
            table_present = true if r['CNT'].to_i != 0
=begin
            if r['CNT'].to_i != 0
              puts "Table '#{table_owner}.#{new_resource.table}' exist"
            else
              puts "Table '#{table_owner}.#{new_resource.table}' NOT exist"
            end
=end
          ensure
            close_test_client
          end
          table_present
        end

      end
    end
  end
end
