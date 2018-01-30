---
layout: example
title: Multicolour Examples
permalink: /examples/
---

# Multicolour examples

Multicolour tries to be as helpful as possible with creating and maintaining your REST APIs.

## Getting Started

Multicolour has a CLI to make your life easier, it includes a helper to create a bare bones project for you to get started with.

`multicolour init .`

in your target directory, this will start a wizard to guide you through the creation of your project. This will generate 3 files for you, `config.js`, `app.js` and `content/blueprints/example.js`

## Blueprints

Using Multicolour allows you to write JSON and get a whole collection of software. If you’ve run `multicolour init` you’ll see a `content/` folder which also contains a `blueprints/` folder where you’ll see `example.js`.

### A look at what we get

Looking at what we get by running `multicolour init .` we can see a few files generated for us. We'll see the following file structure.

{% highlight text %}
- your-project/
  - content/
    - blueprints/
      - example.js
  - config.js
  - app.js
{% endhighlight %}

Your `content/blueprints/example.js` is your first blueprint, lets look at it's anatomy.

{% highlight js linenos %}
"use strict"

module.exports = {
  attributes: {
    name: {
      required: true,
      type: "string"
    },
    age: {
      required: true,
      type: "integer",
      min: 0,
      max: 9000
    },
    password: {
      required: true,
      type: "string",
      minLength: 5
    }
  },

  // Before we create anything, make sure
  // to hash the password for security.
  beforeCreate: (values, next) => {
    // Get the crypto library.
    const crypto = require("crypto")

    // Create a hash, we're going to encrypt the password.
    const password = crypto.createHash("sha1")
    password.update(values.password)

    // Apply the hash to the inbound values.
    values.password = password.digest("hex")

    // Move on.
    next()
  }
}
{% endhighlight %}

The very first thing is the [`"use strict"`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode) pragma, this simply helps prevent silly syntactical errors in your code by catching them early.

`module.exports = {` this is the beginning of our `example` model definition. An object containing various keys and objects that configure both the database(s) and Multicolour.

`attributes: {` are the columns and keys used in our actual database tables and collections, each key represents a column in your table with the associated type.

`beforeCreate: (values, next) => {` is a special function called just before the actual creation of the row within the table/collection. This is your last chance to alter the values of the data being written to the database.

There are many other configurations that you can add to your blueprints to make Multicolour and Waterline work in exactly the way you want but it's important to know that Multicolour tries not to modify any definition in any way, Multicolour fixes some known bugs with Waterline but does not alter your model.
