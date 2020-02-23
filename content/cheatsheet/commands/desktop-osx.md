---
title: desktop-osx
weight: 999
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## homebrew

### install homebrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### install packages

```bash
HOMEBREW_NO_AUTO_UPDATE=1 brew install ...
HOMEBREW_NO_AUTO_UPDATE=1 brew cask install ...
```

## notifications

```bash
osascript -e 'display notification "Body" with title "Title"'
```

## text to voice

```bash
say "Hello World"
```

## clipboard

```bash
pbpaste > output.txt

pbcopy < input.txt
```
