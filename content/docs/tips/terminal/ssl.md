---
title: SSL
weight: 99

---
# SSL

## Lets Encrypt certifiate

### CNAME challenge

```bash
EMAIL=test@example.com

docker run --rm -it --name certbot \
    --volume "${PWD}/etc-letsencrypt:/etc/letsencrypt" \
    --volume "${PWD}/var-lib-letsencrypt:/var/lib/letsencrypt" \
    certbot/certbot \
    certonly --dry-run \
        --manual-public-ip-logging-ok --agree-tos --email="${EMAIL}" \
        --manual \
        --preferred-challenges=dns \
        --domains=DOMAIN_1,DOMAIN_2
```

### Cloudflare challenge

```bash
EMAIL=MY_EMAIL
CLOUDFLARE_API_KEY=MY_API_KEY

echo "dns_cloudflare_email=${EMAIL}\ndns_cloudflare_api_key=${CLOUDFLARE_API_KEY}" > dns-cloudflare.ini
chmod 400 dns-cloudflare.ini

docker run --rm -it --name certbot \
    --volume "${PWD}/etc-letsencrypt:/etc/letsencrypt" \
    --volume "${PWD}/var-lib-letsencrypt:/var/lib/letsencrypt" \
    --volume "${PWD}/dns-cloudflare.ini:/dns-cloudflare.ini" \
    certbot/dns-cloudflare \
    certonly --dry-run  \
        --manual-public-ip-logging-ok --agree-tos --email="${EMAIL}" \
        --dns-cloudflare \
        --dns-cloudflare-credentials /dns-cloudflare.ini \
        --domains=DOMAIN_1,DOMAIN_2
```

## Inspect a server certifiate

```bash
echo | 2>/dev/null openssl s_client \
    -servername hellupline.com.br \
    -connect hellupline.com.br:443 |
openssl x509 -noout -text
```

## Self-Signed Certificate

```bash
openssl req -nodes -x509 -days 365 \
    -newkey rsa:4096 \
    -keyout key.pem \
    -out cert.pem \
    -addext "subjectAltName = DNS:my-other-domain.com,DNS:www.my-other-domain.com" \
    -subj '/CN=my-domain.com'
```