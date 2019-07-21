---
title: Date
tags:
- utils
weight: 

---
# Date

```bash
# RFC-3339
date --date='1991-01-22 19:00:00 +300'
date --rfc-3339=seconds

# Timestamp
date --date='@664581600'
date '+%s'

# Relative
date --date="next Friday"
date --date="2 days ago"
```