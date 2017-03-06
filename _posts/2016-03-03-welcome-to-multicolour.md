---
layout: post
title: Write less code, do more. Welcome to the future.
date: 2016-03-26 08:42:51 +0000
keywords: branding, logo, company, startup
author: Dave Mackintosh
permalink: /blog/introducing-multicolour
lang: en
breadcrumbs:
  - permalink: /blog/
    name: multicolour blog
---

When you’re asked “what do you do each day?” what’s the first thing you think of? Maybe it’s something like “I make web apps” or “I create APIs for apps”. That’s great and it’s a growing market filling with clever people.
What do you really do each day though? You’re probably writing the familiar create, read, update and delete (CRUD) stuff day in, day out to satisfy your client’s needs and wants. That’s cool, it’s age old and it’s your bread and butter.
We all mine through the CRUD to get to the gold; the truly inspirational work in the business logic and the finely tuned front end, the “fun” part of our jobs.
But what if you could get there in minutes instead of days or months? What if you could create a RESTful API with OAuth support for all major platforms, use almost any database technology with full relationship support and JSONAPI compliancy in less than 5 minutes?

### Enter Multicolour
In a world that’s increasingly relying on automated technologies and the web in general, it’s becoming more and more important to be lean. That doesn’t mean we should cut corners, but that we need to get smarter with what we have. We need to do more with the near infinite number of solutions already out there designed to make our lives easier.

That’s where Multicolour sits, firmly. It’s not a framework, it’s not a library, but in fact it is just glue between many other open source projects. If there wasn’t a plethora of incredibly clever people out there, Multicolour wouldn’t exist.

### That’s fine, but what is Multicolour?

Multicolour is a “generator”; built on NodeJS, it generates various things but right now we’re concentrating on generating functional and super fast REST APIs. It uses JSON schemas to generate the create, read, update and delete operations of your API saving you time and preventing you having to repeat your work.

At New World Code, we don’t like having to repeat ourselves when tackling problems shared by multiple projects. We’ve always used a simple fake server generator so we can get started with front ends and mobile apps while the backend is being developed but after working this way for some time, we realised that even faster and smarter alternatives exist. Multicolour was conceived to help us create APIs in 90% less time, generating the repeated boilerplate and glue for us in a matter of seconds.

It was important that it didn’t stop us doing our normal work though, so we made sure the CRUD comes for free. You can get straight to the project specific logic in just a few minutes!

### The feature set for BETA is:
**OAuth support** for Facebook, GitHub, Google, Instagram, LinkedIn, Twitter, Yahoo, Foursquare, VK, ArcGIS Online, Windows Live, Nest, Phabricator, BitBucket, Dropbox, Reddit, Tumblr and Twitch. With built in role support route and verb based controls.

Support for **almost any database technology**, even concurrently. If you have a table; say “projects”, in PostgreSQL and a collection; say “users”, in Mongo, you can relate the two without any code change regardless of the different database technologies or different servers. You can see a list of the supported database technologies here.

**JSONAPI compliancy** to prevent the age old argument on how the data should be represented. Have a well written API spec to send to your developers to work from, safe in the knowledge that the API will follow suite.

**Content Negotiation** was a must. As much as we love JSONAPI at NWC, not all clients can consume it without heaps of work. So if you want straight JSON, ask for application/json but if you want JSONAPI (or any other content type) request it + profit.

**Code-less logic**, if you want to lock those proverbial “projects” in your database to their creator you don’t have to write any business logic to handle that, use Multicolour constraints.

**Self documenting API** with Swagger and Swagger UI, see your endpoints and even try them right in your browser straight away.

Create a **Plugin system** that lets you extend and modify Multicolour’s behaviour without limit.

And many other features but as well as that, we’re building out a new module that can generate a single page, Polymer/React apps to get you rocking and rolling with the front-end as well!

None of these features get in the way of you adding your business logic, all your custom routes and custom logic is written exactly the same as usual in the same place.

### How do I get in on this?!
Multicolour is being very actively developed in plain sight on Github, it’s maturing quickly but it’s still in BETA with enhancements and bug fixes being pushed to the plugins every couple of days.

Head over to the Github repo and star/subscribe for updates as they happen and if you really want to be ahead of the curve you can sign up for occasional updates and exclusive private beta access to modules by email on our website, https://getmulticolour.com

It’s already in the wild with two companies, it’s powering the amazing design tool Context and the Floato app and backend as well as a couple of exciting other projects we can’t talk about today!

We also have a Gitter channel specifically for Multicolour users to get advice and help straight from the horses mouth.

### What’s next for Multicolour?
We’re busy working away on several issues and updates to bring more stability and performance to your APIs so go and star/fork and start work on the interesting solutions for your clients.
