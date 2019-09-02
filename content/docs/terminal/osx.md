---
title: OSX
weight: 99

---

# OSX

## HomeBrew

### Install HomeBrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install Packages

```bash
HOMEBREW_NO_AUTO_UPDATE=1 brew install ...
HOMEBREW_NO_AUTO_UPDATE=1 brew cask install ...
```

## Notifications

```bash
osascript -e 'display notification "Body" with title "Title"'
```

## Text to voice

```bash
say "Hello World"
```

## Clipboard

```bash
pbpaste > output.txt

pbcopy < input.txt
```
