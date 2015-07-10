require 'spec_helper'

describe('oracle_database_test::default') do

  # Table 'table1' not exist
  describe command('su - oracle -c "sqlplus -s system/password <<EOF
    set lin 1000
    set pages 0
    set trims on
    set tab off
    SELECT count(1) AS cnt FROM ALL_TABLES WHERE TABLE_NAME=UPPER(\'table1\') AND OWNER=UPPER(\'system\')
    exit
    EOF
  "') do
    its(:stdout) { should match /0/ }
  end

  # Table 'table2' exist
  describe command('su - oracle -c "sqlplus -s system/password <<EOF
    set lin 1000
    set pages 0
    set trims on
    set tab off
    SELECT count(1) AS cnt FROM ALL_TABLES WHERE TABLE_NAME=UPPER(\'table2\') AND OWNER=UPPER(\'system\')
    exit
    EOF
  "') do
    its(:stdout) { should match /1/ }
  end

=begin
  # User 'piggy' not exist
  describe command('su - oracle -c "sqlplus -s system/password <<EOF
    set lin 1000
    set pages 0
    set trims on
    set tab off
    SELECT count(1) AS cnt FROM ALL_USERS WHERE USERNAME=UPPER(\'piggy\')
    exit
    EOF
  "') do
    its(:stdout) { should match /0/ }
  end

  # User 'piggy1' exist
  describe command('su - oracle -c "sqlplus -s system/password <<EOF
    set lin 1000
    set pages 0
    set trims on
    set tab off
    SELECT count(1) AS cnt FROM ALL_USERS WHERE USERNAME=UPPER(\'piggy1\')
    exit
    EOF
  "') do
    its(:stdout) { should match /1/ }
  end

  # User 'piggy1' can connect to DB
  describe command('su - oracle -c "sqlplus piggy1/wokkawokka <<EOF
    set lin 1000
    set pages 0
    set trims on
    set tab off
    exit
    EOF
  "') do
    its(:stdout) { should match /Connected to/ }
  end

  # User 'piggy1' don't have Insert privileges on 'table2'
  describe command('su - oracle -c "sqlplus piggy1/wokkawokka <<EOF
    set lin 1000
    set pages 0
    set trims on
    set tab off
    insert into system.table2 values(3,\'ggg\')
    exit
    EOF
  "') do
    its(:stdout) { should match /insufficient privileges/ }
  end

  # User 'piggy1' have Select privilege on 'table2'
  describe command('su - oracle -c "sqlplus piggy1/wokkawokka <<EOF
    set lin 1000
    set pages 0
    set trims on
    set tab off
    select * from system.table2
    exit
    EOF
  "') do
    its(:stdout) { should match /rrrrrrrr/ }
  end
=end





=begin
  describe command("echo 'SHOW SCHEMAS;' | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -pub3rs3kur3 | grep databass") do
    its(:exit_status) { should eq 0 }
  end

  describe command("echo 'SHOW SCHEMAS;' | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -pub3rs3kur3 | grep datatrout") do
    its(:exit_status) { should eq 1 }
  end

  describe command("echo 'select User,Host from mysql.user;' | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -pub3rs3kur3 | grep fozzie") do
    its(:exit_status) { should eq 0 }
  end

  describe command("echo 'select User,Host from mysql.user;' | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -pub3rs3kur3 | grep kermit") do
    its(:exit_status) { should eq 1 }
  end
=end
end
