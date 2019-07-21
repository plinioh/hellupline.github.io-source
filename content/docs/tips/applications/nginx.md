---
title: NGINX
weight: 99

---
# NGINX

## How to run a simple static site with nginx and docker

```bash
docker run --rm -it --name=static-site \
    --volume "${PWD}/public:/usr/share/nginx/html" \
    --publish 8080:80 \
    --workdir /usr/share/nginx/html \
    nginx
```