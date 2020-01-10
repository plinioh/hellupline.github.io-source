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
