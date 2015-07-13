
# ======== Install a RDBMS ========
#
# Download RPM from here
#
node.default['oracle-xe']['url'] = 'http://192.168.10.100:8888/d/oracle-xe-11.2.0-1.0.x86_64.rpm'

include_recipe 'oracle-xe'

package ['gcc']

#
# This variables should be set!
#
ENV['ORACLE_HOME'] = "/u01/app/oracle/product/11.2.0/xe"
ENV['LD_LIBRARY_PATH'] = "/u01/app/oracle/product/11.2.0/xe/lib"

gem_package 'ruby-oci8'
# ======== End Install a RDBMS ========




connection_info = {
    host: '//127.0.0.1:1521/XE',
    username: 'system',
    password: 'password'
}

# ======== Tables ========
# Create a table 'table1' :drop against
oracle_database_table 'table1' do
  connection connection_info
  owner 'system'
  columns ['a number', 'b varchar2(10)']
  action :create
end

# Drop a table 'table1'
oracle_database_table 'table1' do
  connection connection_info
  action :drop
end

# Create a table 'table2'
oracle_database_table 'table2' do
  connection connection_info
  columns ['c number', 'd varchar2(20)']
  action :create
end
# ======== End Tables ========


# ======== Users ========
# Create a user 'piggy' :drop against
oracle_database_user 'piggy' do
  connection connection_info
  password 'wokkawokka'
  action :create
end

# Drop a user 'piggy'
oracle_database_user 'piggy' do
  connection connection_info
  action :drop
end

# Create a user 'piggy1'
oracle_database_user 'piggy1' do
  connection connection_info
  password 'wokkawokka'
  action :create
end

# Grant on table 'table2' to user 'piggy1'
oracle_database_user 'piggy1' do
  connection connection_info
  owner 'system'
  table 'table2'
  privileges [:select, :update, :insert]
  action :grant
end

# Revoke on table 'table2' to user 'piggy1'
oracle_database_user 'piggy1' do
  connection connection_info
  table 'table2'
  privileges [:update, :insert]
  action :revoke
end
# ======== End Users ========


# ======== Database ========
# Insert data into 'table2'
oracle_database 'table2' do
  connection connection_info
  sql_query "insert into table2(c, d) values(1,'qwerty')"
  commit true
  action :query
end

# Update data in 'table2'
oracle_database 'table2' do
  connection connection_info
  sql_query "update table2 set d='rrrrrrrr' where rownum = 1"
  commit true
  action :query
end

# Select data from 'table2'
oracle_database 'table2' do
  connection connection_info
  sql_query "select * from table2"
  action :query
end
# ======== End Database ========