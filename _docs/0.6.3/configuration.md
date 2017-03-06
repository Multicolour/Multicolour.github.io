---
layout: docs
title: Multicolour documentation configuration
description: Documentation on configuring and altering configuration for a Multicolour REST API.
keywords: multicolour config, server configuration, rest api config
version: '0.6.3'
short_name: Configuration
contents: false
permalink: /docs/0.6.3/configuration
lang: en
breadcrumbs:
  - permalink: /docs/
    name: docs
  - permalink: /docs/0.6.3/
    name: 0.6.3
---

# Configuration

Multicolour is config driven, it's not a library or a framework but a tool that links all your favourite libraries together to make a restful API.

The config can seem a bit convoluted if all kept in one file and this is why it's a `.js` file and not a `.json` file.

A typical `config.js` might look something like the below and it configures:

* a default timeout on the server of 30 seconds
* the pagination results limit of 20
* a prefix on the API routes of `/api`
* where to write the JavaScript SDK to.
* Where the server should list and on what port, etc (standard Hapi config)
* and two database connections, one for when `NODE_ENV` is development and for production.

{% highlight js %}
"use strict"

const PORT = parseInt(process.env.PORT) || 1811

module.exports = {
  content: `${__dirname}/content`,

  settings: {
    timeout: 3e4,

    results: {
      per_page: 20
    },

    route_prefix: "/api",

    javascript_sdk: {
      destination: `${__dirname}/content/frontend/build/api_sdk`,
      module_name: "API_SDK"
    }
  },
  api_connections: {
    port: PORT,
    routes: {
      cors: {
        origin: [ `http://localhost:${PORT}` ]
      }
    },
    router: { stripTrailingSlash: true }
  },

  api_server: {
    connections: {
      routes: {
        security: true
      }
    },
    debug: { request: ["error"] }
  },

  db: {
    adapters: {
      mongo: require("sails-mongo")
    },
    connections: {
      development: {
        adapter: "mongo",
        database: "multicolour"
      },
      production: {
        adapter: "mongo",
        host: "some-mongo-host.com",
        port: 27017,
        database: "multicolour"
      }
    }
  }
}
{% endhighlight %}

A full config file may contain any of the following options:

{% highlight js %}
"use strict"

module.exports = {
  content: String

  settings: {
    timeout: Number,

    results: {
      per_page: Number
    },

    route_prefix: String,

    javascript_sdk: {
      destination: String,
      module_name: String
    }
  },

  auth: {
    password: String,
    providers: [
      {
        provider: String,
        clientId: String,
        clientSecret: String,
        isSecure: Boolean
      }
    ]
  },

  // As HAPI is the only available server plugin currently
  // it's config options are shown below in briefand you
  // should consult the Hapijs docs for the full configuration
  // documentation.
  api_connections: {
    port: Number,
    host: String,
    routes: {
      cors: Boolean or {
        origin: [ String ]
      }
    },
    router: { stripTrailingSlash: true }
  },

  api_server: {
    connections: {
      routes: {
        security: Boolean
      }
    },
    debug: { request: [ String ] }
  },

  db: {
    adapters: {
      String: require(String)
    },
    connections: {
      String: {
        adapter: String,
        host: String,
        port: Number,
        username: String,
        password: String,
        ssl: Boolean,
        database: String
      }
    }
  }
}
{% endhighlight %}
