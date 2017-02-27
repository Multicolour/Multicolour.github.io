---
layout: docs
title: Multicolour documentation file uploads
permalink: /docs/routing/file-uploads/
---

# Uploading files

If you want to upload files, Multicolour has your back. To support uploading files on your blueprints you simply need to add `can_upload_file: String` to your blueprint.

```javascript
{
  attributes: {
    location: "string"
  },
  can_upload_file: "location"
}
```

The value of `can_upload_file` should be the name of the key on the record to store the location of the uploaded file, if it is `true` "file" will be used.

The upload endpoint will be added to your blueprint as `POST /{identity}/upload` and requires that you create a record before uploading, this endpoint follows the `POST constraint`s

By default Multicolour will upload files to a temporary location as dictated by Node's `os.tmpdir()` function.

We encourage you to create your own storage plugin to set a more permanent storage location or use the `multicolour-storage-S3` plugin.

## Creating a storage plugin.

The default storage plugin will store any files uploaded to the operating system's temp directory. We encourage you to choose a more permanent place for your files by creating your own storage plugin.

Below is a storage plugin that stores files in `/uploads`

```javascript
"use strict"

// Get the tools we need.
const fs = require("fs")

class Multicolour_Disk_Storage {

  /**
   * Create default options and values.
   * @return {Multicolour_Disk_Storage} Object for chaining.
   */
  constructor() {
    // Set up the default options.
    this.options = {
      path: "/uploads"
    }

    return this
  }

  register(multicolour) {
    multicolour.reply("storage", this)
  }

  /**
   * Upload a file to disk and return a writable stream.
   * @param  {multicolour/File} file to upload to S3.
   * @param  {String} destination to write the file to.
   * @return {fs.WritableStream} object to listen for events.
   */
  upload(file, destination) {
    // Check we got a destination.
    if (!destination) {
      throw new ReferenceError("No destination for uploaded file")
    }
    // Upload the file.
    else {
      // We'll return the writable stream.
      const stream = fs.createWriteStream(`${this.options.path}/${destination}`)

      // Check if we got a readable stream, in.
      if (file.pipe) {
        file.pipe(stream)
      }
      // Otherwise, read the file out.
      else {
        fs.createReadStream(file).pipe(stream)
      }

      // Return the stream.
      return stream
    }
  }

  /**
   * Download a file from disk and return
   * an EventEmitter to listen for data events.
   * @param  {multicolour/File} file to get from disk.
   * @return {fs.ReadableStream} object to listen for event
   */
  get(file) {
    return fs.createReadStream(`${this.options.path}/${file}`)
  }
}

// Export the required config for Multicolour to register.
module.exports = Multicolour_Disk_Storage
```

To use your newly created plugin, edit your `app.js` to include it, E.G

```javascript
require("multicolour")
  // Configure the service core and scan for content.
  .new_from_config_file_path("./config.js")
  .scan()

  // Register the server plugin.
  .use(require("multicolour-server-hapi"))

  // Register our storage plugin.
  .use(require("multicolour-disk-storage"))
```

## Advanced storage plugin configuration.

If you want to keep your plugin configurable via the current blueprint's properties storage plugins support `storage_config_keys` resolution.

Inside your `register(multicolour)` function set up a `reply("storage_config_keys")` with an array of the keys you wish to fetch from the blueprint.

Example:

```javascript
// blueprints/upload.js
{
  attributes: {
    location: "string",
    pending: "boolean"
  },

  can_upload_file: "location",
  custom_param: 1234567890
}
```
---

```javascript
// my-storage-plugin.js
...
  /**
   * Set the storage name on our host.
   * @param  {Multicolour} multicolour host instance.
   * @return {void}
   */
  register(multicolour) {
    multicolour
      .reply("storage", this)
      .reply("storage_config_keys", [ "custom_param" ])
  }
...
```
