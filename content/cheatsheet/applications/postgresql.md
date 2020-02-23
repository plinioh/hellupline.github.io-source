---
title: postgresql
weight: 130
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## show where a user has permissions

```sql
SELECT
    a.schemaname,
    a.tablename,
    b.usename,
    HAS_TABLE_PRIVILEGE(b.usename, a.schemaname || '.' || a.tablename, 'select') as select,
    HAS_TABLE_PRIVILEGE(b.usename, a.schemaname || '.' || a.tablename, 'insert') as insert,
    HAS_TABLE_PRIVILEGE(b.usename, a.schemaname || '.' || a.tablename, 'update') as update,
    HAS_TABLE_PRIVILEGE(b.usename, a.schemaname || '.' || a.tablename, 'delete') as delete,
    HAS_TABLE_PRIVILEGE(b.usename, a.schemaname || '.' || a.tablename, 'references') as references
FROM
    pg_tables a,
    pg_user b
WHERE
    a.schemaname = 'example_schema';
```

## show objects ownership

```sql
SELECT
    nsp.nspname as object_schema,
    cls.relname as object_name,
    rol.rolname as owner,
    case cls.relkind
        when 'r' then 'TABLE'
        when 'm' then 'MATERIALIZED_VIEW'
        when 'i' then 'INDEX'
        when 'S' then 'SEQUENCE'
        when 'v' then 'VIEW'
        when 'c' then 'TYPE'
        else cls.relkind::text
    end as object_type
FROM
    pg_class cls
JOIN
    pg_roles rol ON rol.oid = cls.relowner
JOIN
    pg_namespace nsp ON nsp.oid = cls.relnamespace
WHERE
    nsp.nspname NOT IN ('information_schema', 'pg_catalog')
    AND nsp.nspname != 'pg_toast'
    AND rol.rolname = current_user -- remove this if you want to see all objects
ORDER BY
    nsp.nspname,
    cls.relname;
```

## create a read-only access

```sql
-- example schema
CREATE SCHEMA example_schema;

-- example tables
CREATE TABLE example_schema.example_table (key TEXT PRIMARY KEY, value TEXT);
CREATE TABLE example_schema.example_another_table (key TEXT PRIMARY KEY, value TEXT);

-- application role
CREATE ROLE example_app_ro NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION INHERIT;
ALTER DEFAULT PRIVILEGES IN SCHEMA example_schema GRANT SELECT ON TABLES TO example_app_ro;
GRANT USAGE ON SCHEMA example_schema TO example_app_ro;
GRANT SELECT ON ALL TABLES IN SCHEMA example_schema TO example_app_ro;

-- example table read-only role
CREATE ROLE example_table_role_ro NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION INHERIT;
GRANT USAGE ON SCHEMA example_schema TO example_table_role_ro;
GRANT SELECT ON example_schema.example_table TO example_table_role_ro;

-- example another table read-only role
CREATE ROLE example_another_table_role_ro NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION INHERIT;
GRANT USAGE ON SCHEMA example_schema TO example_another_table_role_ro;
GRANT SELECT ON example_schema.example_another_table TO example_table_role_ro;

-- group role, granted example_table_role_ro and example_another_table_role_ro
CREATE ROLE example_group_ro NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION INHERIT;
GRANT example_table_role_ro TO example_group_ro;
GRANT example_another_table_role_ro TO example_group_ro;

-- user role, granted example_group_ro
CREATE ROLE example_user WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION INHERIT LOGIN PASSWORD 'mysecretpassword' VALID UNTIL 'infinity';
GRANT example_group_ro TO example_user;
```

### in redshit

```sql
CREATE GROUP "example_group_ro";
GRANT USAGE ON SCHEMA example_schema TO GROUP example_group_ro;
GRANT SELECT ON ALL TABLES IN SCHEMA example_schema TO GROUP example_group_ro;
```

## inspect default schema privileges

```sql
SELECT
    nsp.nspname,
    case defacl.defaclobjtype
        when 'r' then 'TABLE'
        when 'm' then 'MATERIALIZED_VIEW'
        when 'i' then 'INDEX'
        when 'S' then 'SEQUENCE'
        when 'v' then 'VIEW'
        when 'c' then 'TYPE'
        else defacl.defaclobjtype::text
    end as object_type,
    defacl.defaclacl
FROM
    pg_default_acl defacl
JOIN
    pg_namespace nsp ON defacl.defaclnamespace=nsp.oid;
```

## get user roles

```sql
 SELECT
    a.rolname,
    ARRAY_AGG(b.rolname)
FROM
    pg_roles a,
    pg_roles b
WHERE
    pg_has_role(a.rolname, b.oid, 'member')
GROUP BY
    a.rolname;
```

## redshift

```sql
-- Create a new user
CREATE USER example_user WITH PASSWORD 'mysecretpassword';

-- Add users to an existing group
ALTER GROUP example_group ADD USER example_user;

--- Query to check all groups a user is in
SELECT
    u.usename AS rolname,
    u.usesuper AS rolsuper,
    true AS rolinherit,
    false AS rolcreaterole,
    u.usecreatedb AS rolcreatedb,
    true AS rolcanlogin,
    -1 AS rolconnlimit,
    u.valuntil as rolvaliduntil,
    ARRAY(
        SELECT
            g.groname
        FROM
            pg_catalog.pg_group g
        WHERE
            u.usesysid = ANY(g.grolist)
    ) as memberof
FROM
    pg_catalog.pg_user u
WHERE
    u.usename = 'YOUR_USERNAME_HERE'
ORDER BY
    rolname;
```

## run a postresql in docker

```bash
docker run --rm -it --name my-sgdb \
    --env POSTGRES_PASSWORD=mysecretpassword \
    --env POSTGRES_USER=myuser \
    --env POSTGRES_DB=mydatabase \
    --publish 5432:5432 \
    postgres
```

```bash
docker exec -it my-sgdb \
    psql 'host=localhost user=myuser dbname=mydatabase'
```

```bash
docker run --rm -it postgres \
    psql 'host=myhost user=myuser password=mysecretpassword dbname=mydatabase'
```
