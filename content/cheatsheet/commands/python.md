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
   --force-reinstall \
   --no-compile --no-deps \
   --requirement requirements.txt
```

### install and use

```bash
python3 -m pip install --upgrade --user pipenv

pipenv install boto3

pipenv shell
```
