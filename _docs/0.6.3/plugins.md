---
layout: docs
title: Multicolour documentation plugins
description: Use plugins to create and extend REST API behaviour.
keywords: multicolour, plugins, rest api business logic
version: '0.6.3'
short_name: Writing plugins
contents: false
permalink: /docs/0.6.3/plugins/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
---

# Writing Multicolour Plugins

You've written loads of awesome new functionality in your `custom_routes` callback and are thinking "I'd like to distribute my awesome code as a package", either internally or on npm.

You need a plugin, plugins make sharing and using your custom functionality easy.

## What is a Multicolour plugin?

A Muticolour plugin is simply a class that encapsulates your custom behaviour, there aren't any limitations or locks or blocks to the rest of Multicolour or any other plugins you're using so you can do what you need to do unincumbered.

All plugins are automatically extended with the talkie interface and is assigned a `host` as well as a unique (unique every time) id. Both can be `.request()`-ed directly from your plugin. I.E `this.request("host")` or `this.request("id")`.

## Example Multicolour plugin

An example Multicolour plugin that adds a new route to the route table looks like this:

{% highlight js %}
// This file is called ./plugins/awesome/index.js
module.exports = class {
  // Register is the only required member function.
  register(multicolour) {
    const server = multicolour.get("server").request("raw")

    server.route({
      path: "/hello/{name}",
      config: {
        handler: (request, reply) => {
          reply(`Hey there, ${requet.params.name}`)
        },
        validate: {
          params: {
            name: require("joi").string().required()
          }
        }
      }
    })
  }
}
{% endhighlight %}

Once you've saved your plugin, to use it simply add `.use(require("./plugins/awesome"))` to your main `app.js` or add the path to your plugin to your package.json.

Run your service and your plugin will register and run. Easy as that.
