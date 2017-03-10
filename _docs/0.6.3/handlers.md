---
layout: docs
title: Multicolour REST API method handlers documentation.
description: Multicolour core ships with all the verb handlers built in.
keywords: multicolour, rest api, verbs, handlers
version: '0.6.3'
short_name: Handlers
contents: false
permalink: /docs/0.6.3/handlers/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
---

Each verb comes with it's own handler built into Multicolour, these are

## REST API Verb handlers

The core comes with these handlers so that each of the server plugins behave predictably and the same.

You can reach all the handlers by using the `.get("handlers")` function which will return a class object like this one

```js
{
  POST: Function(model, request, response_interface),
  GET: Function(model, request, response_interface),
  PATCH: Function(model, request, response_interface),
  PUT: Function(model, request, response_interface),
  DELETE: Function(model, request, response_interface)
}
```
