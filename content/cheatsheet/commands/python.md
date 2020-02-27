---
title: python
weight: 170
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---


## pipenv

### lock and lambda-layer

```bash
> requirements.txt pipenv lock --requirements

python3 -m pip install \
   --target ./layer/python/lib/python3.8/site-packages \
   --no-deps --no-compile \
   --requirement requirements.txt
```
