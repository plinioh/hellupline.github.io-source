---
title: mysql
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

# Inspect Bad Queries

```sql
SELECT
    ID, USER, DB, STATE, TIME, INFO
FROM
    information_schema.processlist
WHERE
    COMMAND NOT IN ('Sleep', 'Connect', 'Binlog Dump')
    AND USER NOT IN ('system user')
    AND SUBSTR(USER, 1, 4) != 'app_'
ORDER BY
	  TIME DESC;
```

## create user
```sql
CREATE USER 'user'@'%' IDENTIFIED BY 'PASSWORD';
GRANT SELECT on DATABASE.* TO 'user'@'%';
```

## inspect user permissions
```sql
SHOW GRANTS FOR 'user'@'%';
```

## allow kill process on rds
```sql
GRANT EXECUTE ON PROCEDURE `mysql`.`rds_kill_query` TO `operator`@`%`;
GRANT EXECUTE ON PROCEDURE `mysql`.`rds_kill` TO `operator`@`%`;
GRANT SELECT ON TABLE `information_schema`.`PROCESSLIST` TO `operator`@`%`;
```

## kill query in rds

```sql
SHOW FULL PROCESSLIST; -- or the bad queries above

EXPLAIN FOR CONNECTION PID;

CALL mysql.rds_kill_query(PID);
```


## inspect replication status

```sql
SHOW SLAVE STATUS;

SHOW SLAVE HOSTS;
```
