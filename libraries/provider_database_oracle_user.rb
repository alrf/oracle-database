
require File.join(File.dirname(__FILE__), 'provider_database_oracle')

class Chef
  class Provider
    class Database
      class OracleUser < Chef::Provider::Database::Oracle
        use_inline_resources if defined?(use_inline_resources)

        def whyrun_supported?
          true
        end

        action :create do
          unless user_present?
            #Chef::Log.debug("Creating user '#{new_resource.username}'")
            converge_by "Creating user '#{new_resource.username}'" do
              begin
                repair_sql = "CREATE USER #{new_resource.username} IDENTIFIED BY #{new_resource.password}"
                repair_client.exec(repair_sql)
              ensure
                close_repair_client
              end
            end
          end
        end

        action :drop do
          if user_present?
            converge_by "Dropping user '#{new_resource.username}'" do
              begin
                repair_sql = "DROP USER #{new_resource.username}"
                repair_client.exec(repair_sql)
              ensure
                close_repair_client
              end
            end
          end
        end

        action :grant do
          table_owner = new_resource.owner ? "#{new_resource.owner}" : 'system'
          tbl_name = new_resource.table ? new_resource.table : '*'
          converge_by "Granting privs for '#{new_resource.username}'" do
            begin
              # default - doing grant connect
              repair_sql = "GRANT CONNECT TO #{new_resource.username}"
              repair_client.exec(repair_sql) if new_resource.privileges
              repair_sql = "GRANT #{new_resource.privileges.map(&:upcase).join(',')}"
              repair_sql += " ON #{table_owner}.#{tbl_name}"
              repair_sql += " TO #{new_resource.username}"
              repair_client.exec(repair_sql) if new_resource.privileges
            ensure
              close_repair_client
            end
          end
        end

        action :revoke do
          table_owner = new_resource.owner ? "#{new_resource.owner}" : 'system'
          tbl_name = new_resource.table ? new_resource.table : '*'
          revoke_statement = "REVOKE #{new_resource.privileges.map(&:upcase).join(',')}"
          revoke_statement += " ON #{table_owner}.#{tbl_name}"
          revoke_statement += " FROM #{new_resource.username}"
          converge_by "Revoking access with statement [#{revoke_statement}]" do
            begin
              repair_client.exec(revoke_statement)
            ensure
              close_repair_client
            end
          end
        end

        private

        def user_present?
          user_present = nil
          begin
            test_sql = "SELECT count(1) AS cnt FROM ALL_USERS WHERE USERNAME=UPPER('#{new_resource.username}')"
            test_sql_results = test_client.exec(test_sql)
            r = test_sql_results.fetch_hash
            user_present = true if r['CNT'].to_i != 0
=begin
            if r['CNT'].to_i != 0
              puts "User '#{new_resource.username}' exist"
            else
              puts "User '#{new_resource.username}' NOT exist"
            end
=end
          ensure
            close_test_client
          end
          user_present
        end

      end
    end
  end
end
