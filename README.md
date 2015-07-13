Oracle Database Cookbook
=================
The main highlight of this cookbook is the `database` (sql queries), `database_table` and
`database_user` resources for managing databases, tables and database users in
a RDBMS.

Requirements
------------
Chef version 0.11+

### Platforms
- Red Hat, CentOS

### Cookbooks
The following Chef Software cookbooks are dependencies:

* ruby_oci8

Resources/Providers
-------------------
Leverages the `ruby-oci8` gem, which should be installed prior to use.

### `oracle_database`
Manage databases in a RDBMS.

#### Actions
- :query: execute an arbitrary query against a named database

#### Attribute Parameters
- database_name: name attribute. Name of the database to interact with
- connection: hash of connection info.

- sql: string of sql which will be executed against the database. used by `:query` action
  only

### `oracle_database_table`
Manage tables in a RDBMS.

#### Actions
- :create: create a table
- :drop: drop a table

### `oracle_database_user`
Manage users and user privileges in a RDBMS.

#### Actions
- :create: create a user
- :drop: drop a user
- :grant: grant user privileges on database objects
- :revoke: revoke user privileges on database objects

Examples
------------
Samples of use in: `test/fixtures/cookbooks/oracle_database_test/recipes/default.rb`
