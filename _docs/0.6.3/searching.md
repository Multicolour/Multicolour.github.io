---
layout: docs
title: Multicolour documentation result filtering
description: Perform queries on your data without writing any business logic.
keywords: rest api query, results filtering, searching
version: '0.6.3'
short_name: Results Filtering
contents: false
permalink: /docs/0.6.3/routing/results/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
  - permalink: /docs/0.6.3/routing/
    name: routing
---

Multicolour has a fully featured results filtering engine built out of the box, all your GET requests support this behaviour already.

Assuming you have a table named `person` with this data

| id | name | parent |
|---|---|---|
| 1 | mother | NULL |
| 2 | father | NULL |
| 3 | child 1 | 1 |
| 4 | child 1 | 2 |

we can filter these results by using the query string to find results. See these examples and results:

`GET /person` will return all 4 rows.  

`GET /person?parent=1` & `GET /person?parent[name]=mother` both return

```
{
  "id": 3,
  "name": "child 1",
  "parent": {
    "id": 1,
    "name": "mother"
  }
}
```

because the query string `parent=1` is a simple `WHERE parent=1` and the later, `?parent[name]=mother` finds the ids of the data that match that sub-query and then does a `WHERE parent in [ 1 ]` to return the same row.

You can query your tables using any of the colunmns defined and you can query based on related tables columns too.
