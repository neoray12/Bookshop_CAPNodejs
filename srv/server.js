"use strict";

const cds = require("@sap/cds");
const proxy = require("@sap/cds-odata-v2-adapter-proxy");

// Serve OData v2 Proxy

cds.on("bootstrap", app => app.use(proxy()));

module.exports = cds.server;