---
title: Nginx
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Run a simple static site with nginx and docker

```bash
docker run --rm -it --name=static-site \
    --volume "${PWD}/public:/usr/share/nginx/html" \
    --publish 8080:80 \
    --workdir /usr/share/nginx/html \
    nginx
```


## Run with configuration files

```bash
docker run --rm -it --name=static-site \
    --volume "${PWD}/conf.d:/etc/nginx/conf.d/" \
    --volume "${PWD}/public:/usr/share/nginx/html" \
    --publish 8080:80 \
    --workdir /usr/share/nginx/html \
    nginx
```
