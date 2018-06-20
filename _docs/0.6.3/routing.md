---
layout: docs
title: Multicolour documentation routing
description: Multicolour documentation on generated routes and creating custom routes.
keywords: multicolour, REST API routes, routing
version: '0.6.3'
short_name: Routing
contents: false
permalink: /docs/0.6.3/routing/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
---

# Routing

Multicolour generates a lot of routes for you but your business logic is exactly that, it's yours and yours only. Multicolour doesn't try to handle that for you but saves you the time getting there.

By default Multicolour generates your CRUD interface and configures your auth, validations and Swagger documentation.

Multicolour generates the following for you.

- `POST /{identity}` Create a new `{identity}`
- `PUT /{identity}` Update or create a `{identity}`
- `GET /{identity}?page={page}` Get a paginated  list of `{identity}`
- `GET /{identity}/{id}` Get a single `{identity}` by `{id}`
- `GET /{identity}?{query}&page={page}` Get a paginated list of `{identity}` where `{query}`
- `PATCH /{identity}` Update a `{identity}`
- `DELETE /{identity}` Permanently remove a `{identity}`

Creating your own routes is simple, currently custom routes are not transportable between server technologies but may be in the future.

## The handlers

Multicolour core supplies handlers for pretty much all your verbs out of the box, you can access and use them anytime by `get`ting them from core like below.

{% highlight js %}
const handlers = my_service.get("handlers")

// handlers -> Multicolour_Route_Templates
{% endhighlight %}

## `Multicolour_Route_Templates` class

This class contains all the handlers/route templates, they do the work on the database with the  request data for you. The methods all share the same signature of

`[VERB](model, request, reply)`

Where `[VERB]` is one of the following

{% highlight text %}
POST - Create stuff.
GET - Read stuff.
PATCH - Update stuff.
PUT - Update or create stuff.
DELETE - Delete stuff.
UPLOAD - Upload stuff.
{% endhighlight %}

and where model is retrieved from `my_service.get("database").get("models")`

## The generated routes are nearly there, I want to change something.

You have one last chance to alter the generated routes before they're registered with Hapi, that's done by using the route config middleware available as a callback on every model. This is only available on Multicolour APIs running `multicolour-server-hapi@1.8.2+`.

The callback takes a single argument object with 2 keys, the `verb` that's being configured currently and the current config of the route (`routeConfig`) before it's registered.

**example**:

{% highlight js %}
{
  attributes: {...},
  routeConfigMiddleware: ({routeConfig}) => {
    
    switch (routeConfig.method) {
    case "GET": {
      // This line create a headers object ommiting the authorization key.
      const { authorization, ...headers } = routeConfig.config.validate.headers // eslint-disable-line
      
      return {
        ...routeConfig,
        config: {
          ...routeConfig.config,
          auth: false,
          validate: {
            ...routeConfig.config.validate,
            headers,
          },
        },
      }
    }
    default:
      return routeConfig
    }
  },
}
{% endhighlight %}

## Creating custom routes

You have had a request from the client asking for something Multicolour hasn't already given you and you can't achieve with constraints or the route config middleware, it's time to write a custom route and handler. This is also a great way to ship and share plugins containing re-usable functionality and logic.

Add a `custom_route` property to your blueprint:

{% highlight js %}
{
  attributes: {...},
  custom_routes: function custom_routes(server, multicolour) {
    // Route based on your server technology here.
  }
}
{% endhighlight %}

Multicolour does not interfere, know about or modify anything you do inside of this function. This is your domain and you are free to do what you will.

An example route using the `hapi` server technology might look like this.

{% highlight js %}
{
  attributes: {...},
  custom_routes: function custom_routes(server, multicolour) {
    // this === this blueprint
    server.route({
      method: "GET",
      path: "/project/count",
      handler: (request, reply) => {
        this
          .count({})
          .exec((err, count) => reply[multicolour.request("decorator")](err || count))
      }
    })
  }
}
{% endhighlight %}

## Gotchas while writing custom routes
 As mentioned above, Multicolour makes no effort to watch, change or interfere with your custom routes as we consider `custom_routes` to contain business critical logic.

### Decorators

In order to "decorate" your reply, you should request the `decorator` property stored on Multicolour, `multicolour.request("decorator")`.

### Auth

If you wish to authenticate your custom routes in the same way that Multicolour authenticates your CRUD routes, you must do this manually.

### Validation

Payload and response validations are not created for you and you should implement this yourself.

### Path clashes

If you need to write a custom handler for one of the CRUD operations, currently you need to flag to Multicolour that you don't want to generate routes at all for this blueprint with the `NO_AUTO_GEN_ROUTES` property and write handlers for all the verbs you wish to support.

### Associations

You will not see associations automatically populated, Multicolour has however already fixed and made the associations to other blueprints for you so `.populateAll()` will work for your queries and any decorator plugin should automatically call this for you.
