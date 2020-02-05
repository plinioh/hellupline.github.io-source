---
title: network
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## dns

### query all records

```bash
dig @1.1.1.1 example.com ANY
```

### query records

```bash
dig @1.1.1.1 +short example.com AAAA
```

### trace records tld

```bash
dig @1.1.1.1 +trace example.com AAAA
```

## curl

### debug requests

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

### ip address

```bash
curl https://ifconfig.co/
```

### qr code

```bash
echo "my text" | curl --form 'data=<-' https://qrenco.de/
```

### weather

```bash
curl https://wttr.in/curitiba
```

## netcat

### listen do port

```bash
netcat -vvv -l -p 8000 -s localhost
```

### connect to server

```bash
netcat -vvv localhost 8000
```

### port tunnel

```bash
netcat -vvv -L "localhost:8001" -p 8000 -s localhost
```

## list open ports

```bash
lsof -P -n -i | grep 'LISTEN'
```
