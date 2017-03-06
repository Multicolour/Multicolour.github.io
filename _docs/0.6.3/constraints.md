---
layout: docs
title: Multicolour documentation constraints
description: Add logic to your REST API without writing code
keywords: codeless business logic, multicolour constraints
version: '0.6.3'
short_name: Constraints
contents: false
permalink: /docs/0.6.3/collections/constraints/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
  - permalink: /docs/0.6.3/collections/
    name: collections
---

# Constraints

A constraint in Multicolour is a simple string in your models to define a limiting behaviour on for certain types of actions, such as making sure when something is created it gets assigned the logged in user's identifier for ownership.

Constraints exist to replace simple, common business logic without having to write JavaScript and they come in a few formats that is described in the following spec.

### Specification

{% highlight js %}
{
  [verb String]: {
    [key String]: Function|ComparativeString|ConstraintObject,
  }
}
{% endhighlight %}

Where `ComparativeString` is a `String` with the following format:

{% highlight js %}
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
{% endhighlight %}

and `ConstraintObject` is an `Object` with the following format:

{% highlight js %}
{
  [key String]: {
    compile: Bool false,
    value: compile ? ComparativeString : (String|Number|null)
  },
}
{% endhighlight %}

### Example and common uses

The most common constraint is ensuring a user has sufficient privileges to read|write something and would come in the form of

{% highlight js %}
{
  user: "auth.credentials.user.id"
}
{% endhighlight %}

The way this works is the `String` is a path to an object on the `request` object, this is in-fact setting the constraint to the value of `request.auth.credentials.user.id` in the incoming request.

#### More examples

{% highlight js %}
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
{% endhighlight %}

## Verbs and constraints

You must specify your constraints on all the http verbs you wish to constrain. The verbs must appear as lowercase.

Example:

{% highlight js %}
...
constraints: {
  get: { public: { compile: false, value: true } },
  post: { user: "auth.credentials.user.id" },
  put: { user: "auth.credentials.user.id" },
  delete: { user: "auth.credentials.user.id" },
  patch: { user: "auth.credentials.user.id" }
},
...
{% endhighlight %}
