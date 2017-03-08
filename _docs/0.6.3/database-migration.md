---
layout: docs
title: Multicolour documentation database migration
description: Documentation on the database migration logic, caveats of automatic data migration and how to connect Multicolour to an existing database.
keywords: database, migration, data, existing database, automatic
version: '0.6.3'
short_name: Migration
contents: false
permalink: /docs/0.6.3/collections/migration/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
  - permalink: /docs/0.6.3/collections/
    name: collections
---

Migrating data is difficult, unsafe and generally not recommended but in a development environment it's very helpful while you're changing data types, columns names, adding new collections, etc.

This is why Multicolour has automatic data migration built in, when your environment permits your database changes will be automatically rolled out.

To enable database migration simply set your `NODE_ENV` environmental variable to `development`.
