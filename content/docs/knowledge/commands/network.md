---
title: Network
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Curl

### Debug Requests

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

### IP Address

```bash
curl https://ifconfig.co/
```

### QR Code

```bash
echo "my text" | curl --form 'data=<-' https://qrenco.de/
```

### Weather

```bash
curl https://wttr.in/curitiba
```

## Netcat

### Listen do Port

```bash
netcat -vvv -l -p 8000 -s localhost
```

### Connect to Server

```bash
netcat -vvv localhost 8000
```

### Port Tunnel

```bash
netcat -vvv -L "localhost:8001" -p 8000 -s localhost
```
