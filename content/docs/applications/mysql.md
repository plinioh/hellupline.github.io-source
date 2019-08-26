---
title: Mysql
weight: 99

---
# Mysql

## Create user

```sql
CREATE USER 'USER'@'%' IDENTIFIED BY 'PASSWORD';

GRANT SELECT on DATABASE.* TO 'USER'@'%';
```
