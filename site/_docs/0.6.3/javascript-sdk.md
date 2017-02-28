---
layout: docs
title: Multicolour documentation JavaScript SDK generator
description: Learn how to use the JavaScript, frontend SDK generator to get your web apps up and running faster.
keywords: multicolour, javascript sdk
version: '0.6.3'
short_name: JavaScript SDK
permalink: /docs/0.6.3/javascript-sdk
---

# JavaScript SDK generation

Multicolour comes with an JavaScript SDK generator, it will generate both ES6/ES2015 classes for use with modern libraries like React as well as a standard ES5 library for use anywhere else. It is handwritten code used as templates and Babel transpiles it to today's standard ES5.

To get started with the JavaScript SDK generator, you need configuration in your config file to decide where to put it and whether you want the ES5 code or not.

There is also blueprint level configuration to prevent generation of parts of the SDK.

The config.js should contain an object such as this

{% highlight js %}
settings: {
    ... other config

    javascript_sdk: {
      destination: `${__dirname}/content/frontend/build/api_sdk`,
      module_name: "API_SDK",
      es5: true
    }

    ... other config
  },
{% endhighlight %}

This tells the generator to put the generated code into the `content/frontend/build/api_sdk` folder and name the ES5 module `API_SDK`. The ES5 module is a UMD module so can be `require`d or if no module loader is found is added to `window`.

### I don't want all blueprints generated

The generator respects the `NO_AUTO_GEN_ROUTES` variable used to prevent creation of endpoints for certain models so if you don't want the model generated for a blueprint that has no endpoints, add this option to your blueprint.
