---
layout: docs
title: Multicolour documentation debugging tips
description: Learn how to use the built in debugging tools to debug your REST API faster.
keywords: multicolour, rest api, debugging
version: '0.6.3'
short_name: Debugging
contents: false
permalink: /docs/0.6.3/debugging
---

# Debugging
Multicolour has a few different ways to debug your application, you can start your service with an environmental `DEBUG=multicolour:*` to see logs of internal objects and operations as they happen.

You will see output similar to

{% highlight text %}
multicolour:core Scanning /www/node/multicolour-app/content +2ms
  multicolour:core Scanned and found: [
  "/www/node/multicolour-app/content/blueprints/abode.js",
  "/www/node/multicolour-app/content/blueprints/gadget.js",
  "/www/node/multicolour-app/content/blueprints/person.js",
  "/www/node/multicolour-app/node_modules/multicolour/lib/user-model.js"
] +0ms
  multicolour:core Finished scanning +149ms
{% endhighlight %}

You can also install the `multicolour-hapi-vantage` plugin to see HTTP logs in real time using the `debug on` command in the repl.

While you can use the `DEBUG` environmental in conjunction with the repl, the output may appear garbled as the two share the same stdout.

Starting your service with the vantage plugin installed will take you to a repl (and start your service in the background)

![image](https://cloud.githubusercontent.com/assets/1430657/17627262/7f482b76-60a8-11e6-93eb-83f77c2458d9.png)

Running with the debug mode set to on will show every HTTP request and response in pair to help with debugging.
