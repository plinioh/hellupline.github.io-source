---
title: static-site
weight: 999
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: false

---

{{< code file="/files/configurations/nginx/static-site.conf" language="nginx" download="true" >}}

```bash
docker run --detach --name nginx-static-site \
    --volume "${PWD}/static-site.conf:/etc/nginx/conf.d/default.conf" \
    --volume "${PWD}/files:/var/www/static-site" \
    --publish "8080:80" \
    --workdir "/var/www/static-site" \
    nginx
curl -SsD- http://localhost:8080/
curl -SsD- http://localhost:8080/app/hello-world
docker stop nginx-static-site
docker rm nginx-static-site
```
