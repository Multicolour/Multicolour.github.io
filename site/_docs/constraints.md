---
layout: docs
title: Multicolour documentation constraints
permalink: /docs/collections/constraints/
---

# Constraints

A constraint in Multicolour is a simple string in your models to define a limiting behaviour on for certain types of actions, such as making sure when something is created it gets assigned the logged in user's identifier for ownership.

Constraints exist to replace simple, common business logic without having to write JavaScript and they come in a few formats that is described in the following spec.

### Specification

```javascript
{
  [verb String]: {
    [key String]: Function|ComparativeString|ConstraintObject,
  }
}
```

Where `ComparativeString` is a `String` with the following format:

```javascript
const comparatives = new Map([
  ["<", "<"],
  [">", ">"],
  ["<=", "<="],
  [">=", ">="],
  ["!", "!"],
  ["^", "startsWith"],
  ["$", "endsWith"],
  ["%", "like"]
])

[Comparative?] path.to.data.in.request.object
```

and `ConstraintObject` is an `Object` with the following format:

```javascript
{
  [key String]: {
    compile: Bool false,
    value: compile ? ComparativeString : (String|Number|null)
  },
}
```

### Example and common uses

The most common constraint is ensuring a user has sufficient privileges to read|write something and would come in the form of

```javascript
{
  user: "auth.credentials.user.id"
}
```

The way this works is the `String` is a path to an object on the `request` object, this is in-fact setting the constraint to the value of `request.auth.credentials.user.id` in the incoming request.

#### More examples

```javascript
{
  role: "auth.session.role"
}

{
  name: {
    compile: false,
    value: "Multicolour"
  }
}

{
  createdAt: ">= " + new Date(2015)
}

{
  age: {
    compile: false,
    value: ">= 18"
  }
}
```

## Verbs and constraints

You must specify your constraints on all the http verbs you wish to constrain. The verbs must appear as lowercase.

Example:

```javascript
...
constraints: {
  get: { public: { compile: false, value: true } },
  post: { user: "auth.credentials.user.id" },
  put: { user: "auth.credentials.user.id" },
  delete: { user: "auth.credentials.user.id" },
  patch: { user: "auth.credentials.user.id" }
},
...
```
