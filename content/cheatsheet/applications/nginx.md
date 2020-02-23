---
title: nginx
weight: 140
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## run a simple static site with nginx and docker

```bash
docker run --rm -it --name=static-site \
    --volume "${PWD}/public:/usr/share/nginx/html" \
    --publish 8080:80 \
    --workdir /usr/share/nginx/html \
    nginx
```


## run with configuration files

```bash
docker run --rm -it --name=static-site \
    --volume "${PWD}/conf.d:/etc/nginx/conf.d/" \
    --volume "${PWD}/public:/usr/share/nginx/html" \
    --publish 8080:80 \
    --workdir /usr/share/nginx/html \
    nginx
```
