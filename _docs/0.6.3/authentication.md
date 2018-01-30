---
layout: docs
title: Authentication on your REST API
description: Authentication on your REST API.
keywords: multicolour API, API security, REST API, Authentication
version: '0.6.3'
short_name: API Authentication
contents: false
permalink: /docs/0.6.3/authentication/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
---

Authentication on your REST API is very important and while Multicolour by default is unauthenticated you should use a prebuilt plugin or build a plugin of your own to authenticate your users.

Luckily, there are two plugins for your REST API that provide the most common forms of authentication that are available:

[OAuth](https://github.com/Multicolour/multicolour-hapi-oauth)  
[JWT tokens & Email/password combos](https://github.com/Multicolour/multicolour-auth-jwt)

Both of these plugins will authenticate any endpoint set for authentication.

## Roles

Authenticating users is a good first step but you'll always want different levels of scope for your models. Multicolour has a built in way to handle specific role based authentication features and they're defined per verb and per model to give you the ultimate flexibility.

*Examples*

This example ensures that only an admin can do anything with this particular model.

```javascript
const roles = ["admin"]
const verbs = ["post", "get", "put", "patch", "delete"]

module.exports = {
  roles: verbs.reduce((target, verb) => {
    target[verb] = roles
    return target
  }, {}),

  attributes: {
    campaignName: {
      type: "string",
    },

    campaignVolunteers: {
      collection: "multicolour_user",
    },
  }
}
```

----

This example ensures that only an admin can create, update or delete any of this data but everyone can read it safely.

```javascript
const adminRoles = ["admin"]
const readRoles = ["admin", "user"]
module.exports = {
  roles: {
    post: adminRoles,
    put: adminRoles,
    patch: adminRoles,
    delete: adminRoles,

    get: readRoles,
  },

  attributes: {
    campaignName: {
      type: "string",
    },

    campaignVolunteers: {
      collection: "multicolour_user",
    },
  }
}
```
