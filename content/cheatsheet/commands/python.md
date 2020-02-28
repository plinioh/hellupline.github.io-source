---
title: python
weight: 170
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---


## pipenv

### install and use

```bash
python3 -m pip install --upgrade --user pipenv

pipenv install boto3

pipenv shell
```

### lock and lambda-layer

```bash
> requirements.txt pipenv lock --requirements

python3 -m pip install
   --force-reinstall --no-compile --no-deps \
   --target ./layer/python/lib/python3.8/site-packages \
   --requirement requirements.txt
```

#### pip docker

```bash
> requirements.txt pipenv lock --requirements

docker run --rm -it -w /deps -v "${PWD}:/deps" python:3.8 \
   python3 -m pip install \
      --force-reinstall --no-compile --no-deps \
      --target /deps \
      --requirement /deps/requirements.txt
```
