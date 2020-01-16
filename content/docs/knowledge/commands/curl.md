---
title: Curl Tools
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Debug Requests

```bash
curl \
   --silent --show-error \
   --fail --fail-early \
   --compress --location \
   --create-dirs \
   --dump-header - --output - \
   --write-out '
           time_namelookup:  %{time_namelookup}
              time_connect:  %{time_connect}
           time_appconnect:  %{time_appconnect}
          time_pretransfer:  %{time_pretransfer}
             time_redirect:  %{time_redirect}
        time_starttransfer:  %{time_starttransfer}
                           ----------
                time_total:  %{time_total}
    ' \
   --request GET --url https://example.com
```

## IP Address

```bash
curl https://ifconfig.co/
```

## QR Code

```bash
echo "my text" | curl --form 'data=<-' https://qrenco.de/
```

## Weather

```bash
curl https://wttr.in/curitiba
```
