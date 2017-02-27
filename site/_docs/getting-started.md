---
layout: docs
title: Multicolour quickstart
permalink: /docs/quickstart
---

# Getting Started
Multicolour has a CLI to make your life easier, it includes a helper to create a bare bones project for you to get started with.

`multicolour init .`

in your target directory, this will start a wizard to guide you through the creation of your project. This will generate 3 files for you, `config.js`, `app.js` and `content/blueprints/example.js`

## Blueprints

Multicolour stands on the shoulders of giants, our ORM is the popular [Waterline ORM][waterline]. It has a rich api for creating database schemas without losing control of the underlying technology.

Multicolour uses this to allow you to write JSON and get a whole collection of software. If you've run `multicolour init` you'll see a `content/` folder which also contains a `blueprints/` folder where you'll see `example.js`.

> You said I write JSON to get my stuff

We're not lying, you write JSON and you get your API and frontend but you get `.js` files because you can expand the generated [CRUD][crud] with your business logic by using the [lifecycle][waterline-lifecycle] events and [custom functions][custom-functions] by writing normal JavaScript.

Read more about writing blueprints and extending behaviour in the [Blueprints API reference][blueprints] and on the [Waterline Blueprints documentation][waterline-blueprints].

[waterline]: https://github.com/balderdashy/waterline
[crud]: https://en.wikipedia.org/wiki/Create,_read,_update_and_delete
[waterline-lifecycle]: https://github.com/balderdashy/waterline-docs/blob/master/models/lifecycle-callbacks.md
[custom-functions]: https://github.com/balderdashy/waterline-docs/blob/master/models/instance-class-methods.md
[waterline-blueprints]: https://github.com/balderdashy/waterline-docs/blob/master/models/models.md
[blueprints]: ./Blueprints
