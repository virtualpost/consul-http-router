# Consul HTTP Router

A HTTP router based on NGiNX, routing traffic to all consul registered services with an 'http' tag.

## How to use
Start this service and any services in consul tagged with 'http' will be proxied if a request comes in that matches one of the following:

1. a host address that matches `<servicename>.*`, ie. `hello-world.domain.com`.
2. a url path that matches `/<servicename>/`, ie. http://domain.com/hello-world/.

```
docker run -d -P --dns <consul-host-ip> --dns-search=service.consul virtualpost/consul-http-router 
```

Therefore, there are two ways to access the same service. To get the proxy to work for host-based matching, you will need to create proper DNS host entries that point to your server that runs the router container.

## Using external templates

Default nginx.conf is generated from an internal nginx template file.  This file exists in /templates.  However, you can mount an external data volume or host directory to the container to override and make use of external templates:

```
docker run -d -P --dns-search=service.consul -v /host/path/to/templates:/templates:ro virtualpost/consul-http-router
```

