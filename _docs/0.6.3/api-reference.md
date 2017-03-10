---
layout: docs
title: Multicolour core API reference
description: Multicolour core API reference.
keywords: multicolour API, API reference
version: '0.6.3'
short_name: API Reference
contents: false
permalink: /docs/0.6.3/api-reference/
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
---

Multicolour aims to make your life simpler, smarter and quicker by generating the boilerplate code for you including authentication and data representation layer.

Multicolour core is a message bus that uses the Talkie package.

This allows Multicolour to act as two things:

* An `EventEmitter`  
* a request and reply interface  

The difference between the two is merely semantic, it allows us to make reading the code more natural and simplify certain aspects of the code resolution process *("What does this do?" .. "Oh, that.")*

Multicolour "extends" all plugins with it's message bus so all plugins have a predictable interface.

---

### `new Multicolour({ config })`

Create an instance of Multicolour, `config` should be a valid configuration object for multicolour to scan for blueprints and connect to your databases.

Returns: `Multicolour`  
Example:

```js
const Multicolour = require("multicolour")

const my_service = new Multicolour({
  content: `${__dirname}/content`
})
```

---

### `multicolour.get(key String)`

Get any of the following properties values from Multicolour core, some properties are only available once the service has been `.start()`-ed.

| name  | type  | notes  |
|---|---|---|
| `cli`  | [`cli`](/docs/0.6.3/cli)  | Uninitialised CLI module.  |
| `config`  | [`Config`]({{ site.url }}/docs/0.6.3/configuration)  | The config as a `Map`, top level properties are also `Map`s  |
| `env`  | `String`  | `process.env.NODE_ENV` value at startup or `"development"` by default.  |
| `has_scanned`  | `Boolean`  | whether Multicolour has `.scan()`ned for blueprints.  |
| `package`  | `Object`  | The contents of the app's `package.json` if any  |
| `blueprints`  | [`Object`]({{ site.url }}/docs/0.6.3/collections/#blueprints)  | Only available after `.scan()` has run.  |
| `validators`  | `Map<Object>`  | Map of validators.  |
| `database`  | [`Object`]({{ site.url }}/docs/0.6.3/collections)  | Only available after `.start()` has completed, the database plugin.  |
| `server`  | `Object`  | Only available after `.start()` has completed, the server plugin.  |
| `handlers`  | [`Object`]({{ site.url }}/docs/0.6.3/handlers)  | object with the handlers used by the server plugins and throughout code.  |

Returns: `mixed`  
Example:

```js
console.log(my_service.get("env")) // development
```

Getting core modules such as `database` and `server` will return full plugin instances.

--

### `multicolour.get("database")`

Will return the full `Multicolour_Waterline_Generator` instance including the full waterline object and another Talkie interface.

Much like the `Multicolour.get` interface the database has a number of `.get()`-able properties too.

| name  | type  | notes  |
|---|---|---|
| `models`  | [`Object`](/docs/0.6.3/collections/#models)  | An object of each, raw waterline collection registered. |
| `waterline`  | [`Object`](/docs/0.6.3/collections/#waterline)  | The raw Waterline object underneath. |

---

### `multicolour.get("server")`

All of the official server plugins are also Talkie interfaces which allow for `.get()`-ing of the below properties.

| name  | type  | notes  |
|---|---|---|
| `raw`  | [`mixed`](/docs/0.6.3/server/#raw)  | Raw server tech, be it Hapi or Express or whatever plugin you chose to use. |
| `api_root`  | [`String`](/docs/0.6.3/server/#api_root)  | A string containing the url of where the server is listening. |
| `csrf_enabled`  | [`Boolean`](/docs/0.6.3/server/#csrf)  | A boolean representing whether CSRF is enabled. |

---

### `multicolour.request(key)`

Request a property from Multicolour, this is merely semantic sugar and works exactly the same as `.get(string)`.

Available properties are:

| name  | type  | notes  |
|---|---|---|
| `cli`  | [`CLI`](/docs/0.6.3/cli/)  | initialised CLI module. |
| `new_uuid`  | `String`  | a unique v4 uuid. |
| `storage`  | [`Object`](/docs/0.6.3/routing/file-uploads/)  | Get the current storage plugin. |

Returns: `mixed`  
Example:

```js
console.log(my_service.request("new_uuid")) // 5d31d224-bf23-49ed-9db0-7a50ab924f4f
```

---

### `static new_from_config_file_path(config_location)`

Create a new instance of Multicolour from a config file location.

Returns: `Multicolour`  
Example:

```js
const my_service = require("multicolour").new_from_config_file_path("./config.js")
```

---

### `multicolour.reset_from_config_path(config_location)`

Reset this instance of Multicolour with a config file location.

Returns: `Multicolour`  
Example:

```js
const Multicolour = require("multicolour")
const my_service = Multicolour.new_from_config_file_path("./config.js")

// Actually changed my mind.
my_service.reset_from_config_path("./my-other-config.js")
```

---

### `multicolour.cli()`

Start the CLI tools and parse arguments.

Returns: `CLI`  
Example:

```js
#!/usr/bin/env node

// Get Multicolour.
const Multicolour = require('multicolour')

// Instantiate.
new Multicolour().cli()
```

---

### `multicolour._enable_user_model()`

Enable the core user model, usually done so by official authentication plugins.

Will create a new table/collection in your database called `multicolour_user`.

Returns: `Multicolour`  
Example:

```js
// Get Multicolour.
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()
  ._enable_user_model()
```

---

### `multicolour.scan()`

Tell Multicolour that you and the server are ready to be scanned for blueprints. The search path is dictated by the `config.content` property.

Once scan has completed a new property is made available via the `Multicolour.get()` interface. These are	`"blueprints"`

Returns: `Multicolour`  
Example:

```js
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()
```

---

### `multicolour.use(Plugin)`

Tell Multicolour to register and "use" the supplied plugin. Your plugin must have a `register` method on it.

Returns: `Multicolour`  
Example:

```js
class PingPongPlugin {
  register(Multicolour) {
    Multicolour.reply("ping", "pong")
  }
}

const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()

  // Here we tell Multicolour to use our plugin.
  .use(my_plugin)

console.log(my_service.request("ping")) // pong
```

---

### `multicolour.start()`

Start the database server(s), http server(s) and wait for requests.

Triggers the following events on the Multicolour instance:

* `server_starting`  
* `database_starting`

and once started, triggers  

* `server_started`  
* `database_started`

Also sets up a listener for `SIGINT` on the process so the services can be `.stop()`ped gracefully

Returns: `Promise<database, server>`  
Example:

```js
require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()
  .start()
    .then(() => console.log("Services started"))
```

---

### `multicolour.stop()`

Stop the database server(s) and the http server and stop listening for requests.

Triggers  

* `database_stopping`  
* `server_stopping`  

events on the Multicolour instance and once services are stopped triggers

* `database_stopped`  
* `server_stopped`

Returns: `Promise`  
Example:

```js
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()

my_service.start()
  .then(() => {
    console.log("HTTP & Database server(s) started")

    my_service.stop()
      .then(() => console.log("HTTP & Database server(s) stopped"))
  })
```

---

### Request and Reply arbitrary data

Talkie enables Multicolour to act both as an EventEmitter and as a messaging bus to send arbitrary data to multiple places at once *and* on the object it extends.

Talkie adds `request` and `reply` functions to all extended objects.

### `multicolour.reply(name, data)`

When `name` is `request`ed, it will receive the `data` unmodified.

Example:

```js
multicolour.reply("my_awesome_plugin", new class Awesome {})
console.log(multicolour.request("my_awesome_plugin")) // [Function Awesome]
```

### `multicolour.request(name)`

Purely syntactic sugar, is no different in functionality than `.get(name)`.

Example:

```js
const my_awesome_plugin = multicolour.request("my_awesome_plugin")
```

### EventEmitter

Multicolour is an `EventEmitter`, events can be triggered and listened to using the standard interface for inter-plugin communication.

At **any** point an event can be triggered and listened to in your app's lifetime.

All events are asyncronous, results from a trigger cannot be attained without providing a callback in the data sent.

All plugins that used by Multicolour are also made into message busses with the exact same interface as Multicolour and access to all the Multicolour events.

### Events

These events are fired from core and emit no data.

#### `database_starting`

Emitted with no data when a database startup has been started.

#### `database_started`

Emitted with no data when a database startup has completed.

#### `database_stopping`

Emitted with no data when a database shutdown has been started.

#### `database_stopped`

Emitted with no data when a database shutdown has completed.

#### `server_stopping`

Emitted with no data when a HTTP server shutdown has been started.

#### `server_stopped`

Emitted with no data when a HTTP shutdown has completed.

### multicolour.on(event, callback(event))

Listen for an event fired on Multicolour core.

Returns: `Multicolour`  
Example:

```js
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()

my_service.on("database_started", () =>
  console.log("Bewm, databases are up."))

my_service.start()

```

### multicolour.trigger(event, data)

Trigger an event on Multicolour core.

Returns: `Multicolour`  
Example:

```js
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()

my_service.start()
  .then(() => {
    my_service.trigger("service_up", { my_service })
  })

```

Other methods can be read up on the [Talkie docs](https://www.npmjs.com/package/@newworldcode/talkie)
