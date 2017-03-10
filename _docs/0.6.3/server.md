---
layout: docs
title: Multicolour server docs
description: Multicolour server object documentation.
keywords: multicolour, server, http
version: '0.6.3'
short_name: Server
contents: false
permalink: /docs/0.6.3/server/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
---

A requirement of each server plugin is that it register as `"server"` on Multicolour core. A `server` handles the HTTP side of the data management, all of the official plugins use the `handlers` built into Multicolour so they all behave the same.

## Getting a raw server

All server plugins must expose a way to access the raw technology beneath, this is because for `custom_routes` we use the raw server to pass as an argument.

## Getting the API's URL.

The final resolved url the API can be reached at, is 100% truth once the server has started and only a "guess" before the `server_started` event is emitted.

The guess is 95% correct as it is derived from your configuration file but is not 100%.

To read about what more is available to `.get` or .`request`

## CSRF

All endorsed server plugins are required to implement a way of enabling or disabling CSRF tokens for security reasons.
