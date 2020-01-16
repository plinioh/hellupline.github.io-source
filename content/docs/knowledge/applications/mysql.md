---
title: Mysql
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Create user

```sql
CREATE USER 'user'@'%' IDENTIFIED BY 'PASSWORD';
GRANT SELECT on DATABASE.* TO 'user'@'%';
```

## Inspect User Permissions

```sql
SHOW GRANTS FOR 'user'@'%';
```

## Allow Kill process on RDS

```sql
GRANT EXECUTE ON PROCEDURE `mysql`.`rds_kill_query` TO `operator`@`%`;
GRANT EXECUTE ON PROCEDURE `mysql`.`rds_kill` TO `operator`@`%`;
GRANT SELECT ON TABLE `information_schema`.`PROCESSLIST` TO `operator`@`%`;
```
