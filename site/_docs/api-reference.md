---
layout: docs
title: Multicolour documentation API reference
permalink: /docs/api-reference
---

## Multicolour

Multicolour aims to make your life simpler, smarter and quicker by generating the boilerplate code for you including authentication and data representation layer.

Multicolour core is a message bus, using the [Talkie][talkie] package.

This allows Multicolour to act as two things:

- An `EventEmitter`
- a request and reply interface

The difference between the two is merely semantic, it allows us to make reading the code more natural and simplify certain aspects of the code resolution process *("What does this do?" .. "Oh, that.")*

Multicolour "extends" all plugins with it's message bus so all plugins have a predictable interface.

## `new Multicolour({ config })`

Create an instance of Multicolour, `config` should be a valid configuration object for multicolour to scan for blueprints and connect to your databases.

Returns: `Multicolour`  
Example:

```javascript
const Multicolour = require("multicolour")

const my_service = new Multicolour({
  content: `${__dirname}/content`
})
```

---

## `multicolour.get(key String)`

Get any of the following properties values from Multicolour core, some properties are only available once the service has been `.start()`-ed.

- `"cli"` - `Object` Uninitialised CLI module.
- `"config"` - `Map` The config as a `Map`, top level properties are also `Map`s.
- `"env"` - `String` the `process.env.NODE_ENV` value at startup and `"development"` by default.
- `"has_scanned"` - `Boolean` whether Multicolour has `.scan()`ned for blueprints.
- `"package"` - `Object` The contents of the app's `package.json` if any.
- `"blueprints"` - `Object` Only available after `.scan()` has run.
- `"validators"` - `Multicolour_Default_Validation` class instance for payload and response validation.
- `"handlers"` - `Multicolour_Route_Templates` class instance which contain the default handlers for the database work.
- `"database"` - `Map` Only available after `.start()` has completed, the database plugin.
- `"server"` - `Object` Only available after `.start()` has completed, the server plugin.

Returns: `Any`  
Example:

```javascript
console.log(my_service.get("env")) // development
```

Getting core modules such as `database` and `server` will return full plugin instances.

--

### `multicolour.get("database")`

Will return the full `Multicolour_Waterline_Generator` instance including the full waterline object and another Talkie interface.

Available to `.get`

#### `multicolour.get("database").get("models")`

An object of each, raw waterline collection registered.

#### `multicolour.get("database").get("waterline")`

The raw Waterline object underneath.

--

### `multicolour.get("server")`

A requirement of each server plugin is that it register as `"server"` on Multicolour core

Available to read:

#### `multicolour.get("server").request("raw")`

Raw server tech, be it Hapi or Express or whatever plugin you chose to use.

#### `multicolour.get("server").get("api_root")`

The final resolved url the API can be reached at, is 100% truth once the server has started and only a "guess" before the `server_started` event is emitted.

The guess is 95% correct as it is derived from your configuration file but is not 100%.

To read about what more is available to `.get` or .`request`

#### `multicolour.get("server").request("csrf_enabled")`

All endorsed server plugins are required to implement a way of enabling or disabling CSRF tokens for security reasons.

This will return a `Boolean` as to whether CSRF token generation is enabled or not (defaults to false.)

#### `multicolour.get("server").get("flow_runner")`

Server plugins should implement a `flow_runner` used by Multicolour core as part of it's built in integration testing framework. This should return an executable function.

---

## `multicolour.request(key)`

Request a property from Multicolour, this is merely semantic sugar. Available properties are:

- `"cli"` - `CLI` newly initialised CLI module.
- `"new_uuid"` - `String` a unique v4 uuid.
- `"storage"` - Get the current storage plugin.

Returns: `Any`  
Example:

```javascript
console.log(my_service.request("new_uuid")) // 5d31d224-bf23-49ed-9db0-7a50ab924f4f
```

---

## `static new_from_config_file_path(config_location)`

Create a new instance of Multicolour from a config file location.

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L112-L129)  
Returns: `Multicolour`  
Example:

```javascript
const my_service = require("multicolour").new_from_config_file_path("./config.js")
```

---

## `multicolour.reset_from_config_path(config_location)`

Reset this instance of Multicolour with a config file location.

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L131-L139)  
Returns: `Multicolour`  
Example:

```javascript
const Multicolour = require("multicolour")
const my_service = Multicolour.new_from_config_file_path("./config.js")

// Actually changed my mind.
my_service.reset_from_config_path("./my-other-config.js")
```

---

## `multicolour.cli()`

Start the CLI tools and parse arguments.

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L141-L152)  
Returns: `CLI`  
Example:

```javascript
#!/usr/bin/env node

// Get Multicolour.
const Multicolour = require('multicolour')

// Instantiate.
new Multicolour().cli()
```

---

## `multicolour._enable_user_model()`

Enable the core user model, usually done so by official authentication plugins.

Will create a new table/collection in your database called `multicolour_user`.

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L154-L172)  
Returns: `Multicolour`  
Example:

```javascript
// Get Multicolour.
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()
  ._enable_user_model()
```

---

## `multicolour.scan()`

Tells Multicolour that you and the server are ready to be scanned for blueprints. The search path is dictated by the `config.content` property.

Once scan has completed a new property is made available via the `Multicolour.get()` interface. These are

- `"blueprints"`

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L174-L214)  
Returns: `Multicolour`  
Example:

```javascript
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()
```

---

## `multicolour.use(Plugin)`

Tell Multicolour to register and "use" the supplied plugin. Your plugin must have a `register` method on it.

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L216-L238)  
Returns: `Multicolour`  
Example:

```javascript
class my_plugin {
  register(Multicolour) {
    Multicolour.reply("ping", "pong")
  }
}

const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()

  .use(my_plugin)

console.log(my_service.request("ping")) // pong
```

---

## multicolour.start(callback)

Start the database server(s) and the http server and start listening for requests. When both services are ready `callback` is called.

Triggers  

`server_starting`  
`database_starting`

 events on the Multicolour instance and once services are started triggers  

 `server_started`  
 `database_started`
 events.


Also sets up a listener for `SIGINT` on the process so the services can be `.stop()`ped gracefully

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L240-L269)  
Returns: `Multicolour`  
Example:

```javascript
require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()
  .start(() => console.log("Database server started"))
```

## multicolour.stop(callback)

Stop the database server(s) and the http server and stop listening for requests. When both services are stopped `callback` is called.

Triggers  

`database_stopping`  
`server_stopping`  

events on the Multicolour instance and once services are stopped triggers

`database_stopped`  
`server_stopped`

[Source Code](https://github.com/Multicolour/multicolour/blob/master/index.js#L271-L326)  
Returns: `Multicolour`  
Example:

```javascript
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()

my_service.start(() => {
  console.log("HTTP & Database server(s) started")

  my_service.stop(() => console.log("HTTP & Database server(s) stopped"))
})
```

## Request and Reply arbitrary data

[Talkie][talkie] enables Multicolour to act both as an `EventEmitter` and as a messaging bus to send arbitrary data to multiple places at once and on the object it extends.

Talkie adds `request` and `reply` functions to all extended objects.

### `multicolour.reply(name, data)`

When `name` is `request`ed, it will receive the `data` unmodified.

Example:

```javascript
multicolour.reply("my_awesome_plugin", new class {})
```

### `multicolour.request(name)`

Purely syntactic sugar, is no different in functionality than `.get(name)`.

Example:

```javascript
const my_awesome_plugin = multicolour.request("my_awesome_plugin")
```

## EventEmitter

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

```javascript
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

```javascript
const my_service = require("multicolour")
  .new_from_config_file_path("./config.js")
  .scan()

my_service.start(() => {
  my_service.trigger("service_up", { my_service })
})

```

Other methods can be read up on the [Talkie docs.][talkie]

[talkie]: https://www.npmjs.com/package/@newworldcode/talkie
